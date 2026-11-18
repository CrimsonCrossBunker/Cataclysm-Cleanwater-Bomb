#include "LargeStackObjectCheck.h"

#include <optional>

#include <clang/AST/ASTContext.h>
#include <clang/AST/CharUnits.h>
#include <clang/AST/Decl.h>
#include <clang/AST/DeclBase.h>
#include <clang/AST/Type.h>
#include <clang/ASTMatchers/ASTMatchFinder.h>
#include <clang/ASTMatchers/ASTMatchers.h>
#include <clang/ASTMatchers/ASTMatchersInternal.h>
#include <clang/Basic/Diagnostic.h>
#include <clang/Basic/SourceLocation.h>
#include <clang/Basic/Specifiers.h>
#include <llvm/Config/llvm-config.h>
#include <llvm/Support/Casting.h>

#if !defined(LLVM_VERSION_MAJOR) || LLVM_VERSION_MAJOR < 17
    #include <llvm/ADT/Optional.h>
#endif

using namespace clang::ast_matchers;

namespace clang::tidy::cata
{

void LargeStackObjectCheck::registerMatchers( MatchFinder *Finder )
{
    Finder->addMatcher( varDecl().bind( "decl" ), this );
}

static void CheckDecl( LargeStackObjectCheck &Check, const MatchFinder::MatchResult &Result )
{
    const VarDecl *MatchedDecl = Result.Nodes.getNodeAs<VarDecl>( "decl" );
    if( !MatchedDecl || !MatchedDecl->getLocation().isValid() ) {
        return;
    }

    if( MatchedDecl->getStorageDuration() != SD_Automatic ) {
        return;
    }

    if( MatchedDecl->getName().empty() ) {
        return;
    }

    const QualType QT = MatchedDecl->getType().getCanonicalType();
    const Type *T = QT.getTypePtrOrNull();
    if( !T ) {
        return;
    }

    if( T->isReferenceType() || T->isUndeducedAutoType() ) {
        return;
    }

#if defined(LLVM_VERSION_MAJOR) && LLVM_VERSION_MAJOR >= 22
    // LLVM 22 getTypeInfoImpl segfaults on DTS with null deduced type
    // (CTAD aborted by earlier compile errors).
    if( const auto *DTS = dyn_cast<DeducedTemplateSpecializationType>( T ) ) {
        if( DTS->getDeducedType().isNull() ) {
            return;
        }
    }
#endif

#if defined(LLVM_VERSION_MAJOR) && LLVM_VERSION_MAJOR >= 17
    if( std::optional<CharUnits> VarSize = Result.Context->getTypeSizeInCharsIfKnown( QT ) ) {
#else
    if( Optional<CharUnits> VarSize = Result.Context->getTypeSizeInCharsIfKnown( QT ) ) {
#endif
        int VarSize_KiB = *VarSize / CharUnits::fromQuantity( 1024 );

        if( VarSize_KiB >= 100 ) {
            Check.diag(
                MatchedDecl->getLocation(),
                "Variable %0 consumes %1KiB of stack space.  Putting such large objects on the "
                "stack risks stack overflow.  Please allocate it on the heap instead." ) <<
                        MatchedDecl << VarSize_KiB;
        }
    }
}

void LargeStackObjectCheck::check( const MatchFinder::MatchResult &Result )
{
    CheckDecl( *this, Result );
}

} // namespace clang::tidy::cata
