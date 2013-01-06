using Sxml;
using GLib;
using Gee;

public class Sxml.Example : DataReader, Object {
	protected MarkupTokenType current_token {get; set;}
	protected MarkupSourceLocation begin {get; set;}
	protected MarkupSourceLocation end {get; set;}
	protected XmlStreamReader reader {get; set;}
	public string path { get; construct set; }
	private Map<string, string> atr = new HashMap<string, string> (str_hash, str_equal);
	public string name ;
	public string balance;
	public string banknr;
	public string konr;
	public string typ;
	public MasterState master;
	public Example (string path, string filename) {
		reader = new XmlStreamReader (path+filename);
	}
	public void /*MasterState*/ parse(MasterState master) {
		this.master=master;
		next();
		while (current_token != MarkupTokenType.EOF) {
			next();
			if(reader.name == "General") {
				atr=reader.get_attributes ();
				setmaster();
			}
			if(reader.name == "Bank") {
				atr=reader.get_attributes ();
				setbank();
			}
		}
		//return master;
	}
	public void /*MasterState*/ parse1(MasterState master) {
		this.master=master;
		next();
		while (current_token != MarkupTokenType.EOF) {
			next();
				if(reader.name == "Account") {
				atr=reader.get_attributes ();
				setmap();
			}
			
		}
		//return master;
	}
	
	public void setmaster (){
		foreach (var key in atr.keys) {
			if (key=="File_title") {
			master.file_name=atr.get (key);
			}
		}
		}
	public void setbank (){
		string nam="";
		string num="";
		foreach (var key in atr.keys) {
			if (key=="Nb") {
			num=(atr.get (key));
			}
			if (key=="Na") {
			nam=(atr.get (key));
			}
		}
		if (nam!=""){
		master.addBank(num,nam);
		}
		}

	
	public void setmap (){
		//print("attributes: ");
		foreach (var key in atr.keys) {
			if (key=="Bank") {
				 banknr=atr.get (key);
			}
			if (key=="Name") {
				 name=atr.get (key);
			}
			if (key=="Initial_balance") {
				 balance=atr.get (key);
			}
			if (key=="Number") {
				 konr=atr.get (key);
			}
			if (key=="Kind") {
				 typ=atr.get (key);
			}
		}
		master.addBankKonto (banknr,name,konr, balance,typ);
		}

public string printt(){
		string text="\n";
		text += master.display();
	
	
	
		text +="\n\n";
		
		return text;	
		}
		
}
