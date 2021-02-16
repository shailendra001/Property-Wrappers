
import UIKit

//extension String
//{
//    func isValidEmail(email: String) -> Bool {
//        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,64}"
//        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
//        return pred.evaluate(with: email)
//    }
//}
@propertyWrapper
struct EmailPropertyWrapper
{
    private var _value: String
    var wrappedValue: String
    {
        get
        {
            return isValidEmail(email: _value) ? _value : String()
        }
        set
        {
            _value = newValue
        }
    }

    init(_emailValue: String) {
        _value = _emailValue
    }

    private func isValidEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,64}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: email)
    }
}

struct Employee
{
    @EmailPropertyWrapper var employeeEmailId: String
}

struct User
{
    var name: String
    @EmailPropertyWrapper var email: String

    func validate() -> Bool
    {
        if(name.isEmpty || email.isEmpty)
        {
            debugPrint("name and a valid email is required and cannot be empty")
            return false
        }
        return true
    }

    func registerUser()
    {
        if(validate())
        {
            //saving user records code...
            debugPrint("User data saved")
        }
    }
}

let user = User(name: "codecat15", email: EmailPropertyWrapper(_emailValue:"codecat@15gmail.com"))
print(user.email)
