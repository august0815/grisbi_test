using GLib;
using Gee;

/**
 * TODO: Add documentation here.
 */
public class Konto
{

	 private ArrayList<Transaktion>  transaktion = new ArrayList<Transaktion>();

  /**
   * TODO: Add documentation here.
   */
  private string type;

  private string _kontonr;
  /**
   * TODO: Add documentation here.
   */
  private int _start;
  /**
   * TODO: Add documentation here.
   */
  private string _name;

  /**
   * TODO: Add documentation here.
   */
  public Konto(string name,string start,string konr,string typ){
		this.name=name;
		_start=int.parse(start);
		kontonr=konr;
		type=typ;
		}
	/* Property */
    public int start {
        get { return _start; }
        set { _start = value; }
    } 
    public string kontonr {
        get { return _kontonr; }
        set { _kontonr = value; }
    }
    public string name {
        get { return _name; }
        set { _name = value; }
    }
	public int  addTransaktion(string nb,string datum,string betrag,string gegen,string pa){
		foreach(Transaktion t in transaktion){
			if (nb==t.trans_nr){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			var newtrans=new Transaktion(nb,datum,betrag,gegen,pa);
			transaktion.add(newtrans); 	
			return 0;			
	}
	public ArrayList<Transaktion> getTransaktionen(){
	 	return transaktion;
	}


}

