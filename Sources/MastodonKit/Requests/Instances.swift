import Foundation

public struct Instances {
    /// Gets instance information.
    ///
    /// - Returns: Request for `Instance`.
    public static func current() -> InstanceRequest {
        return InstanceRequest(path: "/api/v1/instance", parse: InstanceRequest.parser)
    }
    
    /// Blocks an instance.
    ///
    /// - Parameter id: The account id.
    /// - Returns: Request for `Relationship`.
    public static func block(domain: String) -> InstanceRequest {
        let parameters = [
            Parameter(name: "domain", value: domain)
        ]
        return InstanceRequest(path: "/api/v1/domain_blocks", method: .post(Payload.parameters(parameters)), parse: InstanceRequest.parser)
    }
    
//    /// Unblocks an account.
//    ///
//    /// - Parameter id: The account id.
//    /// - Returns: Request for `Relationship`.
//    public static func unblock(id: Int) -> RelationshipRequest {
//        return RelationshipRequest(path: "/api/v1/accounts/\(id)/unblock", method: .post(.empty), parse: RelationshipRequest.parser)
//    }
}
