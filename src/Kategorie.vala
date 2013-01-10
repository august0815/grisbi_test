using GLib;
using Gee;
/**
 * TODO: Add documentation here.
 */
public class Kategorie
{
   private ArrayList<Subkategorie>  sub = new ArrayList<Subkategorie>();
	
	public string nummer {get;set;}
	public string name {get;set;}
	public string typ {get;set;}
	
	public Kategorie(string nummer,string name ,string tye){
		this.nummer=nummer;
		this.name=name;
		this.typ=typ;
		}

    public int  addSub(string nummer,string name ,string nbc){
		foreach(Subkategorie s in sub){
			if (nbc==s.nbc){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			var newsub=new Subkategorie(nummer,name,nbc);
			sub.add(newsub); 	
			return 0;			
	}
}

