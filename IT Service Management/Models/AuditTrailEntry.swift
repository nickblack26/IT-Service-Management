import Foundation
import FirebaseFirestore

struct AuditTrail: Codable {
    var text: String?
    var enteredDate: Timestamp?
    var enteredBy: DocumentReference?
    var auditType: AuditType?
    var auditSubType: String?
    var auditSource: String?

    enum CodingKeys: String, CodingKey {
        case text = "text"
        case enteredDate = "enteredDate"
        case enteredBy = "enteredBy"
        case auditType = "auditType"
        case auditSubType = "auditSubType"
        case auditSource = "auditSource"
    }
}

extension AuditTrail {
    enum AuditType: Codable {
        case None, Ticket, Contact, Company, Opportunity, Time, Activity, ProductCatalog, ProjectTicket, Purchasing, Configuration, Schedule, Agreement, AgreementAddition, Project, Invoice, PurchaseOrder, Expense, ProductItem, Survey
    }
}
