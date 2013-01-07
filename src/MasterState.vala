using GLib;

using Gee;


public class MasterState
{
	private string _file_name;

	public ArrayList<Bank>  bank = new ArrayList<Bank>();

  public MasterState()
  {  addBank("0","BARGELD!");
     }
     
          ~MasterState() {
     }
     
     /* Property */
    public string file_name {
        get { return _file_name; }
        set { _file_name = value; }
	}
	
	public void addBank(string num,string nam){
		var newbank=new Bank(nam,num);
		bank.add(newbank); 
		}
	public void addBankKonto(string nr,string name, string konr,string balance,string typ){
		int nnr=int.parse(nr);
		if (nnr<0) {print ("Fehler in gespeicheter Grisbi Datei : Bank='-1'\nBitte die Zuordnung Konto=>Bank bearbeiten und speichern\nError in saved Grisbi file: Bank='-1'\nPlease edit  mapping Account=>Bank and save");
					}
		bank[nnr].addKonto(name,balance,konr,typ);
		} 
	
	public ArrayList<Bank> getBank(){
	 	return bank;
	}
}

