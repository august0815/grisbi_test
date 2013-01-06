using GLib;
using Gtk;
using Sxml;
public class GrisbiFileViewer : Window {
    
	public MasterState master;
    private TextView text_view;
    
    public GrisbiFileViewer () {
     
        master = new MasterState();
        this.title = "Simple Grisbi File Viewer";
        this.window_position = WindowPosition.CENTER;
        set_default_size (800, 600);

        var toolbar = new Toolbar ();
        toolbar.get_style_context ().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);

        var open_button = new ToolButton.from_stock (Stock.OPEN);
        open_button.is_important = true;
        toolbar.add (open_button);
        open_button.clicked.connect (on_openfile_clicked);
        
        this.text_view = new TextView ();
        this.text_view.editable = false;
        this.text_view.cursor_visible = false;

        var scroll = new ScrolledWindow (null, null);
        scroll.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scroll.add (this.text_view);

        var vbox = new Box (Orientation.VERTICAL, 0);
        vbox.pack_start (toolbar, false, true, 0);
        vbox.pack_start (scroll, true, true, 0);
        add (vbox);
    }
 

    private void on_openfile_clicked () {
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
			string filename = _raw_path[_raw_path.length-1];
            string text="File göffnet    " + filename+"\n";
            
            this.text_view.buffer.text = text;
			Example xml = new Example("./",filename);
			xml.parse(master);
			// TODO :doppelt INIT Suboptimal
			Example xml1 = new Example("./",filename);
			xml1.parse1(master);
			text +="              " +master.file_name+"\n";
			
			this.text_view.buffer.text = text+xml.printt();
			master=null;
			master = new MasterState();
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
