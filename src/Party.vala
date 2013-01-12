using GLib;

/**
 * TODO: Add documentation here.
 */
public class Party
{
	public string nummer {get;set;}
	public string name {get;set;}
    public string note {get;set;}
    public string search {get;set;}
    
    public int betrag  {get;set;}

	public Party (string nummer,string name,string note,string search){
		this.nummer=nummer;
		this.name=name;
		this.note=note;
		this.search=search;
		
	}
	

}

