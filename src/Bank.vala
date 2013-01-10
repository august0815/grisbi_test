using GLib;
using Gee;

/**
 * TODO: Add documentation here.
 */
public class Bank
{

  private ArrayList<Konto>  konten = new ArrayList<Konto>();

  /**
   * TODO: Add documentation here.
   */
  public string name {get;set;}


  /**
   * TODO: Add documentation here.
   */
  public int nummer {get;set;}


  /**
   * TODO: Add documentation here.
   */
  

	public Bank(string name,string nummer){
		this.name=name;
		_nummer=int.parse(nummer);
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
	public void addKontoTransaktion(string ac_nr ,string nb,string datum,string betrag,string gegen,string pa){
			foreach (Konto k in konten){
			if (ac_nr==k.kontonr){
					k.addTransaktion(nb,datum,betrag,gegen,pa);
					}
				}
			}
	public ArrayList<Konto> getKonto(){
	 	return konten;
	}

}

