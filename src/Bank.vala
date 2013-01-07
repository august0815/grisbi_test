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
		foreach(Konto k in konten){
			if (konr==k.kontonr){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			var newkonto=new Konto(nam,bal,konr,typ);
			konten.add(newkonto); 	
			return 0;			
	}
	public ArrayList<Konto> getKonto(){
	 	return konten;
	}

}

