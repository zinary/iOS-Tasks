//
//  ViewController.swift
//  Customer Profile
//
//  Created by RamKumar on 27/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
     let gender = ["Male", "Female","other"]
   
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTable: UITableView!
    
    @IBOutlet weak var genderTable: UITableView!

    @IBOutlet weak var TaxExempt: UISwitch!
    @IBOutlet weak var Gender: UIButton!
    @IBOutlet weak var Notes: UITextField!
    @IBOutlet weak var Nationality: UITextField!
    @IBOutlet weak var CreditCard: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Mobile: UITextField!
    @IBOutlet weak var Birthday: UITextField!
    @IBOutlet weak var CustomerIdentityNumber: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var FirstName: UITextField!
    var isSearching = false
    var CustomerData = Customer()
    var storedCustomerData = [Customer]()
    var searchCustomerData = [Customer]()
     var index : Int = 0
    
    override func viewDidLoad() {
        SQlite.shared.deleteDataFromTable(id: 2)
        super.viewDidLoad()
        setupDatepicker()
        setupDatasourcesAndDelegates()
        SQlite.shared.createTable()
        storedCustomerData = SQlite.shared.getDataFromTable()
        searchCustomerData = storedCustomerData
        print(storedCustomerData)
        searchTable.reloadData()
    }
    
    func setupDatasourcesAndDelegates(){
        searchBar.delegate = self
        genderTable.dataSource = self
        genderTable.delegate = self
        searchTable.dataSource = self
        searchTable.delegate = self
        genderTable.isHidden = true
        searchTable.isHidden = true
    }
    // datepicker
    func setupDatepicker()  {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        Birthday.inputView = picker
        picker.addTarget(self, action: #selector(pickerSelected(sender : ) ), for: .valueChanged)
    }
    @objc func pickerSelected(sender : UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        Birthday.text = formatter.string(from: sender.date)
    }
 
    @IBAction func SaveButton(_ sender: Any) {
        CustomerData.FirstName = FirstName.text ?? ""
        CustomerData.Lastname = LastName.text ?? ""
        CustomerData.CustomerIdentityNumber = Int32(CustomerIdentityNumber.text ?? "") ?? 0
        CustomerData.Birthday = Birthday.text ?? ""
        CustomerData.Mobile = Int32(Mobile.text ?? "") ?? 0
        CustomerData.Address = Address.text ?? ""
        CustomerData.Email = Email.text ?? ""
        CustomerData.CreditCard = Int32(CreditCard.text ?? "") ?? 0
        CustomerData.Nationality = Nationality.text ?? ""
        CustomerData.Notes = Notes.text ?? ""
        CustomerData.Gender = Gender.titleLabel!.text!
        let tax = TaxExempt.isOn ? 1 : 0
        CustomerData.TaxExempt = tax
        SQlite.shared.addDatatoTable(CustomerData)
        print("From db\n")
        storedCustomerData = SQlite.shared.getDataFromTable()
        print(SQlite.shared.getDataFromTable())
    }
    
    @IBAction func genderbutton(_ sender: Any) {
        if  genderTable.isHidden == true {
            UIView.animate(withDuration: 0.5) {
            self.genderTable.isHidden = false
            }
        }
        else{
            UIView.animate(withDuration: 0.5) {
                self.genderTable.isHidden = true
            }
        }
    
        
    }
    
    
    //MARK - TABLE SETUP
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        switch tableView {
        case searchTable:
            numberOfRow = searchCustomerData.count
        case genderTable:
            numberOfRow = gender.count
        default:
            print("error in numberOfRow")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        case searchTable:
            cell = searchTable.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
            cell.textLabel?.text = searchCustomerData[indexPath.row].FirstName
            
        case genderTable:
            cell = genderTable.dequeueReusableCell(withIdentifier: "genderCell", for: indexPath)
            cell.textLabel?.text = gender[indexPath.row]
        default:
            print("error in cell")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case searchTable:
            print("selected \(indexPath.row)")
           
            let tempCustomer = searchCustomerData[indexPath.row]
            FirstName.text = tempCustomer.FirstName
            LastName.text = tempCustomer.Lastname
            CustomerIdentityNumber.text = String(tempCustomer.CustomerIdentityNumber)
            Mobile.text = String(tempCustomer.Mobile)
            Birthday.text = tempCustomer.Birthday
            Address.text = tempCustomer.Address
            Email.text = tempCustomer.Email
            Gender.setTitle(tempCustomer.Gender, for: .normal)
            CreditCard.text = String(tempCustomer.CreditCard)
            Nationality.text = tempCustomer.Nationality
            Notes.text = tempCustomer.Notes
            searchTable.isHidden = true
        case genderTable:
            Gender.setTitle("\(gender[indexPath.row])", for: .normal)
            genderTable.isHidden = true
        default:
            print("error in didselect")
        }
        
        
    }
    
}
extension ViewController : UISearchBarDelegate{
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchCustomerData = storedCustomerData.filter({ Customer -> Bool in
            return Customer.FirstName.localizedCaseInsensitiveContains(searchText)
        })
        print(searchCustomerData)
       

        if !searchCustomerData.isEmpty {
            searchTable.isHidden = false
            searchTable.reloadData()
        }
        else{
            searchCustomerData = storedCustomerData
            searchTable.isHidden = false
             searchTable.reloadData()
        }
        
        searchTable.reloadData()
    }
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchTable.reloadData()
        searchTable.isHidden = true
    }
}

