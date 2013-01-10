using GLib;

/**
 * TODO: Add documentation here.
 */
public class Transaktion
{
	public string nummer {get;set;}
	public string datum {get;set;}
	public string betrag {get;set;}
	public string gegenbuchung {get;set;}
	public string pa {get;set;}
	//public string _reserve;
	
	
	public Transaktion(string nummer ,string datum ,string betrag ,string gegen ,string pa){
		this.nummer=nummer;
		this.datum=datum;
		this.betrag=betrag;
		this.gegenbuchung=gegen;
		this.pa=pa;
	}
	
}

