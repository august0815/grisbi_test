using GLib;
using Gtk;
using Sxml;
public class GrisbiFileViewer : Window {
    private Gtk.Builder builder;
    private Gtk.VBox vbox;
	private MasterState master;
    private  TreeView display;
    private  TreeStore store;
    private TextView text_display;
    private TreeSelection selection_konto;
   	private string konto_index="-1";


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
        this.selection_konto = display.get_selection();
		this.selection_konto.changed.connect (get_row_konto);
        setup_tree_display (display);
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
			tree_display();
			}
	private void get_row_konto () {
	TreeModel model;
	TreeIter iter;
    string text="";
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
							text +=t.datum+"  "+t.betrag+"\n";
							}
						}
					
					else { 
						text +="Bitte Konto auswählen";
						}
					}
				}
				this.text_display.buffer.text =text+"\n";
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
