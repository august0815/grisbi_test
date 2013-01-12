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
  public string typ {get;set;}

  public string kontonr {get;set;}
  /**
   * TODO: Add documentation here.
   */
  public int start {get;set;}
  /**
   * TODO: Add documentation here.
   */
  public string name {get;set;}

  /**
   * TODO: Add documentation here.
   */
  public Konto(string name,string start,string konr,string typ){
		this.name=name;
		this.start=int.parse(start);
		this.kontonr=konr;
		this.typ=typ;
		}
		
	public int  addTransaktion(string nb,string datum,string betrag,string gegen,string pa,string Ca,string Sca){
		foreach(Transaktion t in transaktion){
			if (nb==t.nummer){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			var newtrans=new Transaktion(nb,datum,betrag,gegen,pa,Ca,Sca);
			transaktion.add(newtrans); 	
			return 0;			
	}
	public ArrayList<Transaktion> getTransaktionen(){
	 	return transaktion;
	}


}

