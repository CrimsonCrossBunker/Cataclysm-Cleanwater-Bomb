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
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as first, \
                socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as second:
            first.bind(('127.0.0.1', 0))
            second.bind(('127.0.0.1', 0))
            context_ports = [str(first.getsockname()[1]), str(second.getsockname()[1])]
        with open(args.logs / 'contexts.log', 'w', encoding='utf-8') as log:
            contexts = subprocess.run([str(binary), 'contexts', *context_ports],
                                      stdout=log, stderr=log, timeout=30)
        assert contexts.returncode == 0, 'session isolation failed; see contexts.log'
        results.extend(['independent_replication_baselines', 'reset_joins_owned_rust_worker',
                        'two_host_client_pairs_in_one_process', 'session_local_event_queues',
                        'retained_server_lease_does_not_retain_workers',
                        'other_session_survives_stop_and_reconnect', 'owned_welcome_updates'])
        host = start('host', 'host', port)
        assert host.read() == 'READY'
        assert host.command('competing-owner') == 'OK'
        for tag, password, version, reason in [('password', 'wrong', 'abc', 'Wrong password'),
                                               ('version', '口令"\\', 'different', 'Version mismatch')]:
            bad = start(tag, 'client', port, 'player', password, version)
            response = bad.read()
            assert response.startswith('ERROR ') and reason in response, response
            bad.close()
            results.append(tag + '_rejection')
        for tag, identity in [('old_name_based_protocol', {}), ('missing_identity', {}),
                              ('invalid_identity', {'player_id': '../outside', 'resume_secret': 'a' * 64})]:
            invalid = start(tag, 'raw', port)
            assert invalid.read() == 'READY'
            packet = {'type': 'join', 'transport': 'ccb-renet-2', 'password': '口令"\\',
                      'version': 'abc', 'name': 'player', **identity}
            if tag == 'old_name_based_protocol':
                packet['transport'] = 'ccb-renet-1'
            assert invalid.command('send ' + json.dumps(packet)) == 'OK'
            reply = invalid.message()
            expected = 'Incompatible multiplayer transport' if tag == 'old_name_based_protocol' else 'identity required'
            assert reply['type'] == 'error' and expected in reply['message']
            assert host.command('next') == 'EMPTY', 'invalid identity reached actor creation'
            invalid.close()
            results.append(tag + '_rejected_before_spawn')
        client = start('client', 'client', port, '玩家"\\', '口令"\\', 'abc-dirty.123+SDL3')
        assert client.read() == 'READY'
        welcome = client.message()
        assert welcome['world'] == '测试世界"\\\n' and welcome['seed'] == 12345
        assert welcome['host_omt'] == [1, 2, 0]
        assert welcome['world_id'] == 'a' * 32
        assert client.command('pending-setup') == 'OK'
        assert client.command('competing-client') == 'OK'
        assert host.command('competing-client') == 'OK'
        results.extend(['pending_client_survives_initial_setup',
                        'independent_client_preserves_live_client_and_host'])
        assert host.command('next') == 'EMPTY', 'probe spawned a player'
        assert client.command('join-invalid') == 'OK'
        assert host.command('next') == 'EMPTY', 'invalid local profile sent a join'
        assert client.command('join') == 'OK'
        event = host.command('next')
        assert event.startswith('EVENT 0 ') and int(event.split()[2]) > 0, event
        join_welcome = client.message()
        assert join_welcome['type'] == 'welcome' and join_welcome['player_id'] == '1' * 32
        assert 'resume_secret' not in join_welcome
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
        companions = []
        for identity in ('2', '3'):
            companion = start('companion' + identity, 'raw', port)
            assert companion.read() == 'READY'
            packet = {'type': 'join', 'transport': 'ccb-renet-2', 'password': '口令"\\',
                      'version': 'abc', 'name': 'same name', 'world_id': 'a' * 32,
                      'player_id': identity * 32, 'resume_secret': 'b' * 64}
            assert companion.command('send ' + json.dumps(packet)) == 'OK'
            assert host.command('next').startswith('EVENT 0 ')
            assert companion.message()['type'] == 'welcome'
            assert companion.message()['type'] == 'player_joined'
            assert client.message()['type'] == 'player_joined'
            for previous in companions:
                assert previous.message()['type'] == 'player_joined'
            companions.append(companion)
        full = start('full', 'client', port, 'player5', '口令"\\', 'abc')
        assert 'Server is full' in full.read()
        full.close()
        for companion in companions:
            assert companion.command('send ' + json.dumps(action)) == 'OK'
            assert host.command('next').startswith('EVENT 2 ')
        while companions:
            companions.pop().close()
            assert host.command('next').startswith('EVENT 1 ')
            assert client.message()['type'] == 'player_left'
            for remaining in companions:
                assert remaining.message()['type'] == 'player_left'
        results.append('three_remote_players_and_four_player_capacity')
        client.close()
        assert host.command('next').startswith('EVENT 1 '), 'disconnect not delivered'
        reconnect = start('reconnect', 'client', port, '玩家"\\', '口令"\\', 'abc')
        assert reconnect.read() == 'READY'
        reconnect.message()
        reconnect.command('join')
        assert host.command('next').startswith('EVENT 0 ')
        assert reconnect.message()['type'] == 'welcome'
        assert reconnect.message()['type'] == 'player_joined'
        for _ in range(6):
            assert reconnect.command('world-reset') == 'STOPPED'
            assert host.command('next').startswith('EVENT 1 ')
            assert reconnect.command('reconnect-client') == 'READY'
            assert reconnect.message()['type'] == 'welcome'
            assert reconnect.command('pending-setup') == 'OK'
            assert reconnect.command('join') == 'OK'
            assert host.command('next').startswith('EVENT 0 ')
            assert reconnect.message()['type'] == 'welcome'
            assert reconnect.message()['type'] == 'player_joined'
        assert reconnect.command('world-reset') == 'STOPPED'
        assert host.command('next').startswith('EVENT 1 ')
        assert reconnect.command('destructor-client') == 'OK'
        assert host.command('next') == 'EMPTY', 'destroyed pending probe spawned an actor'
        reconnect.close()
        results.extend(['same_process_six_client_world_replacements',
                        'pending_client_destructor_closes_transport'])
        queued = start('queued', 'client', port, 'pending actor', '口令"\\', 'abc')
        assert queued.read() == 'READY'
        queued.message()
        assert queued.command('join') == 'OK'
        assert host.command('await-queued') == 'QUEUED'
        queued.close()
        assert host.command('stop-session') == 'STOPPED'
        for _ in range(12):
            assert host.command('restart') == 'READY'
            assert host.command('stop-session') == 'STOPPED'
        assert host.command('restart') == 'READY'
        assert host.command('next') == 'EMPTY', 'old event entered replacement session'
        assert host.command('destructor-restart') == 'READY'
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as occupied:
            occupied.bind(('127.0.0.1', 0))
            blocked_port = occupied.getsockname()[1]
            assert host.command(f'start-port {blocked_port}').startswith('ERROR ')
            assert host.command('restart') == 'READY'
        assert host.command('worker-failure') == 'READY'
        recovered = start('recovered', 'client', port, 'new session', '口令"\\', 'abc')
        assert recovered.read() == 'READY'
        assert recovered.message()['type'] == 'welcome'
        assert recovered.command('join') == 'OK'
        assert host.command('next').startswith('EVENT 0 ')
        assert recovered.message()['type'] == 'welcome'
        assert recovered.message()['type'] == 'player_joined'
        recovered.close()
        assert host.command('next').startswith('EVENT 1 ')
        results.extend(['independent_owned_hosts', 'same_process_12_rehosts_and_queue_reset',
                        'destructor_with_retained_lease', 'bind_failure_recovery',
                        'worker_failure_recovery_with_real_client'])
        rejected = start('owner-rejection', 'client', port, 'player', '口令"\\', 'abc')
        assert rejected.read() == 'READY'
        assert rejected.message()['type'] == 'welcome'
        assert rejected.command('join') == 'OK'
        rejected_peer = int(host.command('next').split()[2])
        assert rejected.message()['type'] == 'welcome'
        assert rejected.message()['type'] == 'player_joined'
        assert host.command(f'reject {rejected_peer}') == 'OK'
        assert rejected.message() == {'type': 'error', 'message': 'Owner rejected player identity'}
        disconnect = host.command('next').split()
        assert disconnect[0:2] == ['EVENT', '1'] and int(disconnect[2]) == rejected_peer
        rejected.close()
        results.append('owner_admission_rejection_closes_worker_peer')
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
