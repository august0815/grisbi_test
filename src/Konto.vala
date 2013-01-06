using GLib;


/**
 * TODO: Add documentation here.
 */
public class Konto
{


  /**
   * TODO: Add documentation here.
   */
  private string type;

  private string _kontonr;
  /**
   * TODO: Add documentation here.
   */
  private int _start;
  /**
   * TODO: Add documentation here.
   */
  private string name;

  /**
   * TODO: Add documentation here.
   */
 // private Transaktion buchung;
	public Konto(string name,string start,string konr,string typ){
		this.name=name;
		_start=int.parse(start);
		kontonr=konr;
		type=typ;
		}
	public string get_name() {
		return name;
		}
	/* Property */
    public int start {
        get { return _start; }
        set { _start = value; }
    } 
    public string kontonr {
        get { return _kontonr; }
        set { _kontonr = value; }
    }


}

