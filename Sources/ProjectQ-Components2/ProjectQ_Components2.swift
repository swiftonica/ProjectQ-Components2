public class ProjectQ_Components2 {
    public static func configure(basicClient: BasicClientable) {
        self.shared.basicClient = basicClient
    }
    
    static let shared = ProjectQ_Components2()
    private init() {}
    
    var basicClient: BasicClientable?
}
