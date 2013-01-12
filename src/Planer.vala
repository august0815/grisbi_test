using GLib;

/**
 * TODO: Add documentation here.
 */
public class Planer
{
	public string nummer {get;set;}
	public string datum {get;set;}
	public string konto {get;set;}
 	public string betrag {get;set;}
	public string kategorie {get;set;}
	public string party {get;set;}
	public string subkategorie {get;set;}
	public string _transfer_konto;
	public string _pn;
	public string cpn;
	public string _rechnungs_jahr;
	public string _budget_nr;
	public string _subbudget_nr;
	public string _notiz;	
	public string _auto;
	public string _periode;
	public string _perioden_ln;
    public string _limit;
    public string _breakdown;
	public string _mother_tr;
	
	public Planer (string nummer,string datum,string betrag,string party,string kategorie,string subkategorie){
		this.nummer=nummer;
		this.datum=datum;
		this.betrag=betrag;
		this.party=party;
		this.kategorie=kategorie;
		this.subkategorie=subkategorie;
		}

}

