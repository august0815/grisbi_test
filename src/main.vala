using GLib;
using Gtk;
using Sxml;
using Cairo;
public class GrisbiFileViewer : Window {
    private Gtk.Builder builder;
    private Gtk.VBox vbox;
	private Gtk.Calendar calendar;
	private Gtk.Label label;
	private Gtk.DrawingArea drawing_area;
	
    private  TreeView display;
    private  TreeStore store;
    private  TextView text_display;
    
    private TreeSelection selection_konto;
        
   	private string konto_index="-1";

	private MasterState master;
	
	private int tt;
	private int mm;
	private int jj;
private const int SIZE = 50;
    public GrisbiFileViewer () {
     
        master = new MasterState();
        this.title = "Simple Grisbi File Viewer";
        this.window_position = WindowPosition.CENTER;
        set_default_size (800, 600);
		this.load_from_file (); 
		vbox = this.builder.get_object ("vbox") as Gtk.VBox;
        this.add (vbox); 
        vbox.show ();
        display = this.builder.get_object ("treeview") as Gtk.TreeView;
        text_display = this.builder.get_object ("textview1") as Gtk.TextView;
        calendar = this.builder.get_object ("calendar") as Gtk.Calendar;
        label = this.builder.get_object ("datum_label") as Gtk.Label;
        drawing_area =  this.builder.get_object ("drawingarea") as Gtk.DrawingArea;
        drawing_area.draw.connect (on_draw);
        
       // Place a visual marker on a particular day:
        this.calendar.mark_day (1);
        this.selection_konto = display.get_selection();
		this.selection_konto.changed.connect (get_row_konto);
        setup_tree_display (display);
        // Connect signals:

		this.calendar.day_selected_double_click.connect (() => {
			
			this.jj=calendar.year;
			this.mm=calendar.month+1;
			//print("%s: %04d-%02d-%02d   ---- %02d\n", "DATUM", calendar.year, calendar.month, calendar.day, mm);
			this.tt=calendar.day;
			this.label.set_text("Neues Datum :"+mm.to_string()+"/"+tt.to_string()+"/"+jj.to_string());
			//set_markup("%s %d %s %d %s %d".printf("Datum=",mm,"/",tt,"/",jj));
			});

        this.menu ();
    }
	 private bool load_from_file() {
        try {
            this.builder = new Gtk.Builder ();
            this.builder.add_from_file ("main.ui");
            return false;
        } catch (Error e) {
            printerr ("Could not load UI: %s\n", e.message);
            return true;
        }
    }
        private void menu () {
		
        Gtk.ImageMenuItem menu_about =  this.builder.get_object ("about") as Gtk.ImageMenuItem;
        menu_about.activate.connect (() => {
		
        });
         var toolbutton_open = this.builder.get_object ("open") as Gtk.ToolButton;
         toolbutton_open.clicked.connect (() => {
		 on_openfile_clicked();

	   });
	   
   }

    private void on_openfile_clicked () {
		master=null;
		master = new MasterState();
        var file_chooser = new FileChooserDialog ("Grisbi  FILE Select", this,
                                      FileChooserAction.OPEN,
                                      Stock.CANCEL, ResponseType.CANCEL,
                                      Stock.OPEN, ResponseType.ACCEPT);
        if (file_chooser.run () == ResponseType.ACCEPT) {
			open_file (file_chooser.get_filename ().split("/"));
        }
        file_chooser.destroy ();
    }

    
    private void open_file ( string[]? _raw_path = null ) {
			string dir = "";
			string filename = _raw_path[_raw_path.length-1];
			for (int i=0;i<_raw_path.length-1;i++){
				 dir      += "/"+_raw_path[i]; }
				 dir +="/";
			
            string text="File göffnet    " + filename+"\n";
        	Example xml = new Example(dir,filename);
			xml.parse(master);
			text +="              " +master.file_name+"\n";
			rechne();
			tree_display();
			//on_draw();
			}
	private void rechne(){
		var party= master.getParty();
		var bank=master.getBank();
		var cat= master.getKategorie();
		foreach (Bank b in bank){
			var konto=b.getKonto();
				foreach (Konto k in konto){
				   var transaktion=k.getTransaktionen();
					 foreach (Transaktion t in transaktion){
						  int betrag=int.parse(t.betrag);
						  string pa=t.pa;
						  foreach(Party p in party){
						  if (pa==p.nummer){
						  p.betrag += betrag;
								}
						  foreach (Kategorie c in cat){
							  var sub=c.getSub();
							if (t.kategorie==c.nummer){
								foreach(Subkategorie s in sub){
									if(t.subkategorie==s.nummer){
										s.betrag += betrag;
										}
									}
								}
							}		
						}
					}
				}
			}
		}

	
	private void get_row_konto () {
	TreeModel model;
	TreeIter iter;
    string text="";
    string text1="";
	if( this.selection_konto.get_selected (out model, out iter) ) {
	model.get (iter, 0, out konto_index);
		}
			var bank= master.getBank();
			foreach (Bank b in bank){
				var konto=b.getKonto();
				foreach (Konto k in konto){
				if (konto_index==k.name){
					text +="   " +b.name;
					text +="    "+k.name+"\n";
					var transaktion=k.getTransaktionen();
					foreach (Transaktion t in transaktion){
							text1 +=t.datum+"  "+t.betrag+"\n";
							}
						}
					
					else { 
						text1 +="Bitte Konto auswählen";
						}
					}
				}
				var cat= master.getKategorie();
			    for (int i=0;i< cat.size;i++){
				  if (cat[i].name!=""){
					if (konto_index==cat[i].name){
					text1="";
					text +="   " +cat[i].name+"\n";
					var sub=cat[i].getSub();
				 
						for (int ii=0;ii< sub.size;ii++){
						text1 +=sub[ii].name+"  "+sub[ii].betrag.to_string()+"\n";
						}
					}
					}
				}

			var party= master.getParty();
				for (int i=0;i< party.size;i++){
				  if (party[i].name!=""){
					if (konto_index==party[i].name){
					text1="";
						text1 +=party[i].name+"  "+party[i].betrag.to_string()+"\n";
						}
					}
					}

			
			this.text_display.buffer.text =text+text1+"\n";
			text="";
			konto_index="-1"; 
			
	}
	

	private void setup_tree_display (TreeView view){
		store = new TreeStore (2, typeof (string), typeof (string));
        view.set_model (store);

        view.insert_column_with_attributes (-1, "Bank", new CellRendererText (), "text", 0, null);
        view.insert_column_with_attributes (-1, "KontoStand", new CellRendererText (), "text", 1, null);
	}
	
	private void tree_display(){
		store.clear();
		TreeIter root;
        TreeIter category_iter;
        TreeIter product_iter;

        store.append (out root, null);
        store.set (root, 0, master.file_name, -1);
		var bank= master.getBank();
		
		foreach (Bank b in bank ){
			store.append (out category_iter, root);
			var konto=b.getKonto();
			foreach (Konto k in konto){
			store.set (category_iter, 0, b.name, -1);
			store.append (out product_iter, category_iter);
			store.set (product_iter, 0, k.name, 1, k.start.to_string(), -1);
					}
				}
		store.append (out  root ,null);
		store.set (root, 0, "Empfänger", -1);
		store.append (out category_iter, root);
		store.set (category_iter, 0, "Empfänger", -1);
		var party= master.getParty();
			   for (int i=0;i< party.size;i++){
				  if (party[i].name!=""){
				
	  			store.append (out product_iter, category_iter);
				store.set (product_iter, 0, party[i].name, 1, party[i].betrag.to_string(), -1);
							}
					}
		store.append (out  root ,null);
		store.set (root, 0, "Kategorie", -1);
		store.append (out category_iter, root);
		store.set (category_iter, 0, "UnterKategorie", -1);
		var cat= master.getKategorie();
			   for (int i=0;i< cat.size;i++){
				  if (cat[i].name!=""){
				 var sub=cat[i].getSub();
				store.append (out category_iter, root);
				store.set (category_iter, 0,cat[i].name , -1);
			for (int ii=0;ii< sub.size;ii++){
			
			store.set (category_iter, 0, cat[i].name, -1);
			store.append (out product_iter, category_iter);
			store.set (product_iter, 0, sub[ii].name, 1, sub[ii].betrag.to_string(), -1);
					}
							}
					}
         	}
     private bool on_draw (Widget da, Context ctx) {
        ctx.set_source_rgb (0, 0, 0);
        ctx.set_line_width (2);
        ctx.set_tolerance (0.1);
        ctx.set_line_join (LineJoin.ROUND);
        ctx.set_dash (new double[] {SIZE / 2.0, SIZE / 4.0}, 0);
        stroke_shapes (ctx, 0, 0);
        return true;
      } 
          private void stroke_shapes (Context ctx, int x, int y) {
        this.draw_shapes (ctx, x, y, ctx.stroke);
    }
    private delegate void DrawMethod ();

    private void draw_shapes (Context ctx, int x, int y, DrawMethod draw_method) {
        ctx.save ();

        ctx.new_path ();
        ctx.translate (x + SIZE, y + SIZE);
        bowtie (ctx);
        draw_method ();

       
        ctx.restore();
    }
        private void bowtie (Context ctx) {
        ctx.move_to (0, 0);
        ctx.rel_line_to (2 * SIZE, 3 * SIZE);
        ctx.rel_line_to (-3 * SIZE, 0);
        ctx.rel_line_to (2 * SIZE, -3 * SIZE);
        ctx.close_path ();
    }     
	private void print_date (string context) {
		print ("%s: %04d-%02d-%02d\n", context, calendar.year, calendar.month, calendar.day);
	}

    public static int main (string[] args) {
		
        Gtk.init (ref args);

        var window = new GrisbiFileViewer ();
        window.destroy.connect (Gtk.main_quit);
        window.show_all ();
		
        Gtk.main ();
        return 0;
    }
}
