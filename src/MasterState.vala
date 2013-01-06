using GLib;

using Gee;


public class MasterState
{
	private string _file_name;

	public ArrayList<Bank>  bank = new ArrayList<Bank>();

  public MasterState()
  {  print ("MasterState");
	 addBank("0","BARGELD!");
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
		print (" %s   %s " ,name,balance);
		int nnr=int.parse(nr);
		print ("NNR %d\n",nnr);
		if (nnr<0) {print ("fehler");
					}
		print ("NNR %d\n",nnr);
		print ("Bank Nr_NAME %s ",bank[nnr].get_name()); 
		bank[nnr].addKonto(name,balance,konr,typ);
		} 
	
    public string display(){
		string text="";
		foreach (Bank b in bank ){
			text +="Bank Name          :" +b.get_name()+"  Bank Nummer   :"+b.nummer.to_string()+"\n";
			text +="------------------------------------------------------------------------\n";
			text +=b.display();
			}
			return text;
			}
}

