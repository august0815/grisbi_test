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
	public string accountnr;
 	public string tran_nr;
	public string datum;
	public string amount;
	public string trt;
	public string pa;
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
			if(reader.name == "Party") {
				atr=reader.get_attributes ();
				setparty();
			}
			if(reader.name == "Category") {
				atr=reader.get_attributes ();
				setcategory();
			}
			if(reader.name == "Scheduled") {
				atr=reader.get_attributes ();
				setplaner();
			}
			
		}
		//Nochmal Durchsuchen vom Start
		reset();
		next();
		while (current_token != MarkupTokenType.EOF) {
			next();
			if(reader.name == "Account") {
				atr=reader.get_attributes ();
				setmap();
			}
			if(reader.name == "Sub_category") {
				atr=reader.get_attributes ();
				setsubcat();
			}
		}
		//Nochmal Durchsuchen vom Start
		reset();
		next();
		while (current_token != MarkupTokenType.EOF) {
			next();
				if(reader.name == "Transaction") {
				atr=reader.get_attributes ();
				settrans();
			}
		}
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
		if (nam!="")
		master.addBank(num,nam);
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
		if (banknr!="")
		master.addBankKonto (banknr,name,konr, balance,typ);
		}
		public void setparty (){
		string Nb="";
		string Na="";
		string Txt="";
		string search="";
		foreach (var key in atr.keys) {
			if (key=="Nb") {
				 Nb=atr.get (key);
			}
			if (key=="Na") {
				 Na=atr.get (key);
			}
			if (key=="Txt") {
				 Txt=atr.get (key);
			}
			if (key=="Search") {
				 search=atr.get (key);
			}
		}
		if (Nb!="")
		master.addParty (Nb,Na,Txt,search);
		}
		public void setplaner (){
		string Nb="";
		string Dt="";
		string Am="";
		string Pa="";
		string Ca="";
		string Sca="";
		foreach (var key in atr.keys) {
			if (key=="Nb") {
				 Nb=atr.get (key);
			}
			if (key=="Dt") {
				 Dt=atr.get (key);
			}
			if (key=="Am") {
				 Am=atr.get (key);
			}
			if (key=="Pa") {
				 Pa=atr.get (key);
			}
			if (key=="Ca") {
				 Ca=atr.get (key);
			}
			if (key=="Sca") {
				 Sca=atr.get (key);
			}
		}
		if (Nb!="")
		master.addPlaner (Nb,Dt,Am,Pa,Ca,Sca);
		}
		public void setcategory(){
		string Nb="";
		string Na="";
		string Typ="";
		foreach (var key in atr.keys) {
			if (key=="Nb") {
				 Nb=atr.get (key);
			}
			if (key=="Na") {
				 Na=atr.get (key);
			}
			if (key=="Kd") {
				 Typ=atr.get (key);
			}
		}
		if (Nb!="")
		master.addKategorie (Nb,Na,Typ);
		}
		
		public void setsubcat(){
		string Nb="";
		string Na="";
		string Nbc="";
		foreach (var key in atr.keys) {
			if (key=="Nbc") {
				 Nbc=atr.get (key);
			}
			if (key=="Nb") {
				 Nb=atr.get (key);
			}
			if (key=="Na") {
				 Na=atr.get (key);
			}
		}
		if (Nb!="")
		master.addSubKategorie (Nbc,Nb,Na);
		}
		
		public void settrans (){
		string Ca="";
		string Sca="";
		foreach (var key in atr.keys) {
			if (key=="Ac") {
				 accountnr=atr.get (key);
			}
			if (key=="Nb") {
				 tran_nr=atr.get (key);
			}
			if (key=="Dt") {
				 datum=atr.get (key);
			}
			if (key=="Am") {
				 amount=atr.get (key);
			}
			if (key=="Trt") {
				 trt=atr.get (key);
			}
			if (key=="Pa") {
				 pa=atr.get (key);
			}
			if (key=="Ca") {
				 Ca=atr.get (key);
			}
			if (key=="Sca") {
				 Sca=atr.get (key);
			}
		}
		if (accountnr!="")
		master.addBankKontoTransaktion(accountnr,tran_nr,datum,amount,trt,pa,Ca,Sca);
		}

		
}
