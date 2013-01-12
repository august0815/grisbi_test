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
	
	public int betrag  {get;set;}
	
	public Kategorie(string nummer,string name ,string typ){
		this.nummer=nummer;
		this.name=name;
		this.typ=typ;
		addSub(this.nummer,"0","nicht zugeordnet");
		}

    public int  addSub(string nbc,string nummer ,string name){
		foreach(Subkategorie s in sub){
			if (nummer==s.nummer){ 
				/*print ("Ist schon vorhanden")*/
			return 0;}
			}
			var newsub=new Subkategorie(nummer,name,nbc);
			sub.add(newsub); 	
			return 0;			
	}
	public ArrayList<Subkategorie> getSub(){
	 	return sub;
	}
}

