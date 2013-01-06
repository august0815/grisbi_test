using GLib;
using Gee;

/**
 * TODO: Add documentation here.
 */
public class Bank
{

 public ArrayList<Konto>  konten = new ArrayList<Konto>();

  /**
   * TODO: Add documentation here.
   */
  private string name;


  /**
   * TODO: Add documentation here.
   */
  private int _nummer;


  /**
   * TODO: Add documentation here.
   */
  

	public Bank(string name,string nummer){
		this.name=name;
		_nummer=int.parse(nummer);
		}
	
	public string get_name() {
		return name;
		}
	public void setname(string bk) {
		name=bk;
		}
		
   /* Property */
    public int nummer {
        get { return _nummer; }
        set { _nummer = value; }
    }
    public int  addKonto(string nam,string bal,string konr,string typ){
		print ("KONTONR %s \n",konr);
		foreach(Konto k in konten){
			print ("KONTONR %s \n",konr);
			if (konr==k.kontonr){ print ("Ist schon vorhanden");return 0;}
		}
				print ("NEUES KONTO\n");	
				var newkonto=new Konto(nam,bal,konr,typ);
					konten.add(newkonto); 	
			return 1;			
	}
	public string display(){
		string text="";
		foreach (Konto k in konten ){
			text +="Konto Name          :" +k.get_name()+"  AnfangsKapital   :"+k.start.to_string()+"\n";
			}
		return text;}
	

}

