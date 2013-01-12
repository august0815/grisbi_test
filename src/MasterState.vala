using GLib;

using Gee;


public class MasterState
{
	public  string file_name {get;set;}
	
	private ArrayList<Bank>  bank = new ArrayList<Bank>();
	private ArrayList<Kategorie>  kategorie = new ArrayList<Kategorie>();
	private ArrayList<Planer>  planer = new ArrayList<Planer>();
	private ArrayList<Party>  party = new ArrayList<Party>();
	
	
  public MasterState()
  {  addBank("0","BARGELD!");
     }
     
          ~MasterState() {
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
	public void addBankKontoTransaktion(string ac_nr ,string nb,string datum,string betrag,string gegen,string pa,string Ca,string Sca){
		foreach (Bank b in bank){
			b.addKontoTransaktion(ac_nr ,nb,datum,betrag,gegen,pa,Ca,Sca);
			}
		}
	public void addKategorie (string Nb,string Na,string Typ){
		var newcat = new Kategorie(Nb,Na,Typ);
		kategorie.add(newcat);
	   }
	public void addSubKategorie(string Nbc ,string Nb,string Na){
		foreach (Kategorie k in kategorie){
			if (k.nummer==Nbc)
			k.addSub (Nbc,Nb,Na);
			}
		}	
	public void addParty(string nummer,string name,string note,string search){
		var newparty = new Party(nummer,name,note,search);
		party.add(newparty);
		}
	public void addPlaner(string nummer,string datum,string betrag,string party,string kategorie,string subkategorie){
		var newplaner = new Planer(nummer,datum,betrag,party,kategorie,subkategorie);
		planer.add(newplaner);
		}
	
	
	public ArrayList<Bank> getBank(){
	 	return bank;
	}
	
	public ArrayList<Party> getParty(){
	 	return party;
	}
	public ArrayList<Kategorie> getKategorie(){
	 	return kategorie;
	}
	public ArrayList<Planer> getPlaner(){
	 	return planer;
	}
}

