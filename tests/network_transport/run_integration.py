#!/usr/bin/env python3
"""Exercise CCB's real host/client adapters in separate processes (no game UI)."""
import argparse
import json
from pathlib import Path
import selectors
import shutil
import socket
import subprocess
import tempfile
import time


class Peer:
    def __init__(self, binary, logs, tag, *args):
        self.log = open(logs / (tag + '.log'), 'w', encoding='utf-8')
        self.process = subprocess.Popen([str(binary), *map(str, args)], stdin=subprocess.PIPE,
                                        stdout=subprocess.PIPE, stderr=self.log, text=True,
                                        encoding='utf-8', bufsize=1)
        self.selector = selectors.DefaultSelector()
        self.selector.register(self.process.stdout, selectors.EVENT_READ)

    def read(self, timeout=10):
        assert self.selector.select(timeout), 'subprocess response timeout'
        line = self.process.stdout.readline().rstrip('\n')
        assert line, f'subprocess exited: {self.process.poll()}'
        return line

    def command(self, command):
        self.process.stdin.write(command + '\n')
        self.process.stdin.flush()
        return self.read()

    def message(self):
        line = self.command('next')
        assert line.startswith('MESSAGE '), line
        return json.loads(line[len('MESSAGE '):])

    def close(self):
        if self.process.poll() is None:
            self.process.stdin.write('stop\n')
            self.process.stdin.flush()
            try:
                self.process.wait(timeout=8)
            except subprocess.TimeoutExpired:
                self.process.kill()
                self.process.wait()
                raise AssertionError('subprocess did not stop')
        self.selector.close()
        self.log.close()
        assert self.process.returncode == 0, self.process.returncode


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('binary', type=Path)
    parser.add_argument('--logs', type=Path, required=True)
    parser.add_argument('--incompatible-library', type=Path, required=True)
    args = parser.parse_args()
    binary = args.binary.resolve()
    args.logs.mkdir(parents=True, exist_ok=True)
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
        sock.bind(('127.0.0.1', 0))
        port = sock.getsockname()[1]
    peers = []
    results = []

    def start(tag, *options):
        peer = Peer(binary, args.logs, tag, *options)
        peers.append(peer)
        return peer

    try:
        host = start('host', 'host', port)
        assert host.read() == 'READY'
        for tag, password, version, reason in [('password', 'wrong', 'abc', 'Wrong password'),
                                               ('version', '口令"\\', 'different', 'Version mismatch')]:
            bad = start(tag, 'client', port, 'player', password, version)
            response = bad.read()
            assert response.startswith('ERROR ') and reason in response, response
            bad.close()
            results.append(tag + '_rejection')
        client = start('client', 'client', port, '玩家"\\', '口令"\\', 'abc-dirty.123+SDL3')
        assert client.read() == 'READY'
        welcome = client.message()
        assert welcome['world'] == '测试世界"\\\n' and welcome['seed'] == 12345
        assert welcome['spawn_omt'] == [1, 2, 0]
        assert host.command('next') == 'EMPTY', 'probe spawned a player'
        assert client.command('join') == 'OK'
        event = host.command('next')
        assert event.startswith('EVENT 0 ') and int(event.split()[2]) > 0, event
        assert client.message()['type'] == 'welcome'
        assert client.message()['type'] == 'player_joined'
        results.append('deferred_join_seed_unicode_and_peer_identity')
        raw = start('raw', 'raw', port)
        assert raw.read() == 'READY'
        large = {'type': 'state', 'data': 'x' * (96 * 1024)}
        assert host.command('send ' + json.dumps(large)) == 'OK'
        assert client.message() == large
        assert raw.command('next') == 'EMPTY', 'unauthenticated peer received world data'
        results.extend(['compressed_96k_snapshot', 'authenticated_broadcast_only'])
        assert raw.command('send {"type":"action","action":"wait"}') == 'OK'
        assert raw.message()['type'] == 'error'
        raw.close()
        for sequence in range(8):
            packet = {'type': 'state', 'sequence': sequence}
            assert host.command('send ' + json.dumps(packet)) == 'OK'
        for sequence in range(8):
            assert client.message()['sequence'] == sequence
        results.append('ordered_state_delivery')
        action = {'type': 'action', 'action': 'wait'}
        assert client.command('send ' + json.dumps(action)) == 'OK'
        assert host.command('next').startswith('EVENT 2 ')
        full = start('full', 'client', port, 'player3', '口令"\\', 'abc')
        assert 'Server is full' in full.read()
        full.close()
        results.append('existing_game_capacity_enforced')
        client.close()
        assert host.command('next').startswith('EVENT 1 '), 'disconnect not delivered'
        reconnect = start('reconnect', 'client', port, '玩家"\\', '口令"\\', 'abc')
        assert reconnect.read() == 'READY'
        reconnect.message()
        reconnect.command('join')
        assert host.command('next').startswith('EVENT 0 ')
        reconnect.close()
        assert host.command('next').startswith('EVENT 1 ')
        host.close()
        host2 = start('rehost', 'host', port)
        assert host2.read() == 'READY'
        host2.close()
        results.append('disconnect_reconnect_same_port_rehost')
        unused = start('timeout', 'client', port, 'player', '', 'abc')
        begun = time.monotonic()
        assert 'Timed out' in unused.read()
        assert time.monotonic() - begun < 8
        unused.close()
        results.append('bounded_udp_handshake')
        with tempfile.TemporaryDirectory(prefix='ccb-loader-') as temporary:
            temporary = Path(temporary)
            isolated = temporary / binary.name
            shutil.copy2(binary, isolated)
            missing = subprocess.run([str(isolated), 'client', str(port), 'player', '', 'abc'],
                                     capture_output=True, text=True, timeout=8, check=True)
            assert missing.stdout.startswith('ERROR '), missing.stdout
            shutil.copy2(args.incompatible_library, temporary / args.incompatible_library.name)
            incompatible = subprocess.run([str(isolated), 'client', str(port), 'player', '', 'abc'],
                                          capture_output=True, text=True, timeout=8, check=True)
            assert 'incompatible CCB co-op ABI' in incompatible.stdout, incompatible.stdout
        results.append('missing_runtime_and_incompatible_abi')

        print(json.dumps({'passed': results, 'count': len(results)}, ensure_ascii=False, indent=2))
    finally:
        for peer in reversed(peers):
            if peer.process.poll() is None:
                peer.close()


if __name__ == '__main__':
    main()
