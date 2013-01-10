using GLib;

/**
 * TODO: Add documentation here.
 */
public class Party
{
	private string _nummer;
	private string _name;
    private string _note;
    private string _search;

	public Party (string nummer,string name,string note,string search){
		this.nummer=nummer;
		this.name=name;
		this.note=note;
		this.search=search;
		
	}
	
	public string nummer {
        get { return _nummer; }
        set { _nummer = value; }
        }
	 public string name {
        get { return _name; }
        set { _name = value; }
        }
	 public string note {
        get { return _note; }
        set { _note = value; }
        }
	 public string search {
        get { return _search; }
        set { _search = value; }
        }

}

