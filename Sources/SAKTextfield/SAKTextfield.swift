import UIKit

public class SAKTextfield: UITextField {

    public var allowCharacters: CharacterSet = CharacterSet().inverted
    public var maxCharacterNumber: Int?
    public var updatedText: ((String?) -> Void)?
    public var externalDelegate: UITextFieldDelegate?
    public var maskString: String?

    public func setDefault(text defaultValue: String) {
        if let maskString = maskString {
            self.text = defaultValue.apply(mask: maskString)
        } else {
            self.text = defaultValue
        }
    }

    public func unmaskedString() -> String? {
        guard let mask = maskString else {
            return self.text
        }
       return self.text?.unmask(mask: mask)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addingDelegateAndTarget()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        addingDelegateAndTarget()
    }

    private func addingDelegateAndTarget() {
        self.addTarget(self, action: #selector(self.editingChange), for: .editingChanged)
        self.delegate = self
    }

    @objc func editingChange() {
        guard let mask = self.maskString else {
            self.updatedText?(self.text)
            return
        }
        self.text = self.text?.unmask(mask: mask).apply(mask: mask)
        self.updatedText?(self.text?.unmask(mask: mask))
    }

}

extension SAKTextfield: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.externalDelegate?.textFieldDidBeginEditing?(textField)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.externalDelegate?.textFieldDidEndEditing?(textField)
    }

    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {

        if let text = textField.text,
           let max = maxCharacterNumber,
           text.count >= max,
           !string.isEmpty {
            return false
        }

        return self.externalDelegate?.textField?(textField,
                                                 shouldChangeCharactersIn: range,
                                                 replacementString: string) ?? (string.rangeOfCharacter(from: allowCharacters.inverted) == nil)
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.externalDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return self.externalDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }

    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.externalDelegate?.textFieldDidEndEditing?(textField, reason: reason)
    }

    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if #available(iOS 13.0, *) {
            self.externalDelegate?.textFieldDidChangeSelection?(textField)
        }
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.externalDelegate?.textFieldShouldClear?(textField) ?? true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.externalDelegate?.textFieldShouldReturn?(textField) ?? true
    }

}
