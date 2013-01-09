using GLib;

/**
 * TODO: Add documentation here.
 */
public class Transaktion
{
	private string _nb;
	private string _datum;
	private string _betrag;
	private string _gegenbuchung;
	private string _pa;
	//private string _reserve;
	
	
	public Transaktion(string nummer ,string datum ,string betrag ,string gegen ,string pa){
		this.trans_nr=nummer;
		this.datum=datum;
		this.betrag=betrag;
		this.gegenbuchung=gegen;
		this.pa=pa;
	}
	 public string trans_nr {
        get { return _nb; }
        set { _nb = value; }
        }
     public string datum {
        get { return _datum; }
        set { _datum = value; }
        }
     public string betrag {
        get { return _betrag; }
        set { _betrag = value; }
        }
     public string pa {
        get { return _pa; }
        set { _pa = value; }
        }
   	 public string gegenbuchung {
        get { return _gegenbuchung; }
        set { _gegenbuchung = value; }
        }
}

