//
//  VCHome.swift
//  adidas_hackathon
//
//  Created by Sergio Redondo on 27/05/2018.
//  Copyright © 2018 adidasar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class VCHome: UIViewController, UITableViewDelegate, UITableViewDataSource,WebRequestDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var btnVS: UIButton!
    
    var global: Bool = false
    
    var infoChallenge: [NSDictionary] = []
    var globalDic: NSDictionary = [:]
    
    var dicPush: [NSMutableDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        
        //fetchMatch()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infoChallenge = []
        globalDic = [:]
        dicPush = []
        getDataUser()

        let index = table.indexPathForSelectedRow
        if index != nil{
            table.deselectRow(at: index!, animated: false)
        }
    }
    
    func getDataUser(){
        let uid = Auth.auth().currentUser?.uid
        Dataholder.sharedInstance.firDataBaseRef.child("Users").child(uid!).child("Challenge").observeSingleEvent(of: .value, with: { data in
            print("ENTRE CON DATOS")
            for dataSon in data.children {
                
                let dataSonSnapshot = dataSon as? DataSnapshot
                
                let typeChallenge = dataSonSnapshot?.childSnapshot(forPath: "type").value as? String
                let state = dataSonSnapshot?.childSnapshot(forPath: "state").value as? String
                print("INFO DATOS: ", "type: " + typeChallenge! + " state: " + state!)
                if typeChallenge == "predefined" && state == "active"{
                    let dic = dataSonSnapshot?.value as! NSMutableDictionary
                    dic["key"] = dataSonSnapshot?.key
                    self.infoChallenge.append(dic)
                    self.dicPush.append(dic)
                }else if typeChallenge == "global"  && state == "active"{
                    let dic = dataSonSnapshot?.value as! NSMutableDictionary
                    dic["key"] = dataSonSnapshot?.key
                    self.globalDic = (dic)
                    self.global = true
                    self.dicPush.append(dic)
                }else{
                    let dic = dataSonSnapshot?.value as! NSMutableDictionary
                    dic["key"] = dataSonSnapshot?.key
                    self.dicPush.append(dic)
                }
                
            }
            self.table.reloadData()
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(global){
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Test: ", section)
        if global {
            if section == 0 {
                return 1
            }else{
                return infoChallenge.count
            }
        }else{
            return infoChallenge.count
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("CREO CELDAS")
        if global {
            print("SOY GLOBAL")
            if indexPath.section == 0{
                //cellGlobal
                let cell:TVCChallengeGlobal = tableView.dequeueReusableCell(withIdentifier: "cellGlobal", for: indexPath) as! TVCChallengeGlobal
                
                //cell.backgroundColor = UIColor(red: 22, green: 58, blue: 95, alpha: 1.0)
                
                print("PREDEFINED: ", infoChallenge[indexPath.row])
                return cell
            }else{
                let cell:TVCChallenge = tableView.dequeueReusableCell(withIdentifier: "cellChallenge", for: indexPath) as! TVCChallenge
                
                //cell.backgroundColor = UIColor(red: 22, green: 58, blue: 95, alpha: 1.0)
                var texto: String = ""
                if (infoChallenge[indexPath.row]["distance"]) as? Double != 0 {
                    texto = (infoChallenge[indexPath.row]["typeSport"] as? String)! + " \((infoChallenge[indexPath.row]["distance"] as? Double)! / 1000) km"
                }else{
                    texto = (infoChallenge[indexPath.row]["typeSport"] as? String)! + " until burn \((infoChallenge[indexPath.row]["kcal"] as? Double)!) kcal"
                }
                cell.lblCellTitle.text = texto
                
                if (infoChallenge[indexPath.row]["mode"]) as? String == "enable"{
                    cell.viewOpacity.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                    cell.viewProgress.progress = 0.7
                }else{
                    cell.viewOpacity.layer.cornerRadius = 16
                    cell.viewOpacity.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                    cell.viewProgress.progress = 0
                }
                
                print("PREDEFINED: ", infoChallenge[indexPath.row])
                return cell
            }
            
        }else{
            print("NO SOY GLOBAL")
            let cell:TVCChallenge = tableView.dequeueReusableCell(withIdentifier: "cellChallenge", for: indexPath) as! TVCChallenge
            
            //cell.backgroundColor = UIColor(red: 22, green: 58, blue: 95, alpha: 1.0)
            print("DATA: ",globalDic)
            var texto: String = ""
            if (infoChallenge[indexPath.row]["distance"]) as? Double != 0 {
                texto = (infoChallenge[indexPath.row]["typeSport"] as? String)! + " \((infoChallenge[indexPath.row]["distance"] as? Double)! / 1000) km"
            }else{
                texto = (infoChallenge[indexPath.row]["typeSport"] as? String)! + " until burn \((infoChallenge[indexPath.row]["kcal"] as? Double)!) kcal"
            }
            cell.lblCellTitle.text = texto
            print("PREDEFINED: ", infoChallenge[indexPath.row])
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if global {
            if indexPath.section == 0 {
                print("AVANTI")
                
                self.performSegue(withIdentifier: "trCellToGlobal", sender: self)
                
            }else{
                self.performSegue(withIdentifier: "trCellToInfo", sender: self)
            }
        } else {
            self.performSegue(withIdentifier: "trCellToInfo", sender: self)
        }
        
        //tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    @IBAction func fetchMatch(){
        
        let uid = Auth.auth().currentUser?.uid
        
        //print("START MATCH")http://34.253.229.234:3000/0PP8VypRx3hmqt0IallK8lQg21D2/match
        WebRequest.sharedInstance.getGenericRequest(url: "http://34.253.229.234:3000/" + uid! + "/match", delegate: self)
        
        btnVS.setTitle("Buscando...", for: .normal)
        
        
    }
    
    func WRDComunication(result: String) {
        
        print("RESULT: ", result)
        let uid = Auth.auth().currentUser?.uid
        if result == "Wait please!"{
            
            Dataholder.sharedInstance.firDataBaseRef.child("Users").child(uid!).child("Challenge").observe(.childAdded, with: {data in
                
                let temp = data.value as? NSDictionary
                
                if(temp!["type"] as? String == "match"){
                    self.btnVS.setTitle( "Match encontrado, VS: " + (temp!["oponentID"] as? String)!, for: .normal)
                    
                }
                
            })
            
        }else{
            let temp = convertToDictionary(text: result)
            print("TEMP: ", temp)
            if(temp != nil){
                Dataholder.sharedInstance.firDataBaseRef.child("Users").child(uid!).child("Challenge").childByAutoId().setValue(temp)
                var dic2 = temp
                let uid = Auth.auth().currentUser?.uid
                let uidOther = dic2!["oponentID"] as? String
                dic2!["oponentID"] = uid!
                
                Dataholder.sharedInstance.firDataBaseRef.child("Users").child(uid!).child("Challenge").childByAutoId().setValue(dic2)
                
            }
        }
        
       /* Dataholder.sharedInstance.firDataBaseRef.child("Users").child(uid!).child("Challenge").observe(.childAdded, with: { data in
            print("Fetch: ", data.value)
            
            if (data.childSnapshot(forPath: "type").value) as? String == "match" {
                //TODO NUEVO RIVAL ENCONTRADO
                
                print("MATCH ENCONTRADO!!")
            }
            
        })
 */
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                
                return try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //trCellToInfo
        if segue.identifier == "trCellToInfo" {
            if let vcSegue = segue.destination as? VCInfoChallenge {
                let index = table.indexPathForSelectedRow
                vcSegue.dicInfo = infoChallenge[(index?.row)!]
                vcSegue.dicAll = dicPush
                vcSegue.txt = (table.cellForRow(at: (index)!) as! TVCChallenge).lblCellTitle.text!
            }
        }
        
    }
    
}

