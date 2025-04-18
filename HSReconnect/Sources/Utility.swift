import Foundation
import Security

/// Runs pfctl with given arguments, prompting for admin credentials if needed.
func runPfctl(args: [String]) throws {
    var authRef: AuthorizationRef?
    let flags: AuthorizationFlags = [.extendRights, .interactionAllowed]
    let status = AuthorizationCreate(nil, nil, flags, &authRef)
    guard status == errAuthorizationSuccess, let authRef = authRef else {
        throw NSError(domain: NSOSStatusErrorDomain, code: Int(status), userInfo: nil)
    }

    let toolPath = "/usr/sbin/pfctl"
    let cArgs = args.map { strdup($0) } + [nil]
    var pipe: FILE?

    let rc = AuthorizationExecuteWithPrivileges(
        authRef,
        toolPath,
        AuthorizationFlags.preAuthorize,
        cArgs,
        &pipe)
    if rc != errAuthorizationSuccess {
        throw NSError(domain: NSOSStatusErrorDomain, code: Int(rc), userInfo: nil)
    }

    var waitStatus: Int32 = 0
    wait(&waitStatus)
}
