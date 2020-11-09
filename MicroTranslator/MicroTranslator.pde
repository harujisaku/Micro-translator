import java.io.IOException;
import java.net.*;
import javax.swing.*;
import java.awt.*;
import java.net.URL;
import java.io.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusAdapter;
import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;

JLayeredPane pane;
JTextField trans;
JTextField text;
JPopupMenu textmenu = new JPopupMenu();
JPopupMenu transmenu = new JPopupMenu();
JMenuItem textcopy = new JMenuItem("copy");
JMenuItem transcopy = new JMenuItem("copy");
JMenuItem textpaste = new JMenuItem("paste");
String url="https://script.google.com/macros/s/AKfycbzvbsjOnmB22F4n7hdaEYwRAXnHlIVKgZhv_Rsdg4-Qylo8qw/exec?word=";
void setup() {
	size(200, 190);
	surface.setAlwaysOnTop(true);
	Canvas canvas = (Canvas) surface.getNative();
	pane = (JLayeredPane) canvas.getParent().getParent();
	text = new JTextField();
	trans = new JTextField();
	text.addActionListener(enterActionListener);
	trans.setEditable(false);
	text.setBounds(10, 10, 180, 30);
	trans.setBounds(10, 150, 180, 30);
	text.addFocusListener(new FocusAdapter() {
		@Override public void focusGained(FocusEvent e) {
			((JTextField) e.getComponent()).selectAll();
		}
	});
	trans.addFocusListener(new FocusAdapter() {
		@Override public void focusGained(FocusEvent e) {
			((JTextField) e.getComponent()).selectAll();
		}
	});
	pane.add(text);
	pane.add(trans);

	textmenu.setPopupSize(120,50);
	transmenu.setPopupSize(120,25);
	textcopy.addActionListener(new myListener());
	transcopy.addActionListener(new myListener());
	textpaste.addActionListener(new myListener());
	textmenu.add(textcopy);
	textmenu.add(textpaste);
	transmenu.add(transcopy);
	text.setComponentPopupMenu(textmenu);
	trans.setComponentPopupMenu(transmenu);
	fill(255,50,20);
	PImage icon =loadImage("translator.png");
	image(icon,50,50,100,100);
	text("翻訳前",0,10);
	text("翻訳後",0,140);
	thread("firstTrans");


}
class myListener implements ActionListener{
	public void actionPerformed(ActionEvent e){
		JMenuItem mi = (JMenuItem)e.getSource();
		if(mi==textcopy) setClipboardString(text.getText());
		if(mi==transcopy) setClipboardString(trans.getText());
		if(mi==textpaste) text.setText(getClipboardString());
	}
}
private ActionListener enterActionListener = new ActionListener() {
	@Override
	public void actionPerformed(ActionEvent e) {
		translate();
	}
};

void draw() {
}

void firstTrans(){
	text.setText("hello world");
	translate();
}

void translate(){
	if(text.getText()!=null){
		try{
			trans.setText(getText(url+URLEncoder.encode(text.getText(), "UTF-8")));
		}catch(IOException e){
		}
	}
}

void mousePressed(){
	try{
		text.setText(getClipboardString());
		trans.setText(getText(url+URLEncoder.encode(getClipboardString(), "UTF-8")));
		setClipboardString(trans.getText());
	}catch(IOException e){
	}
}

String getText(String url) throws IOException {
	HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
	int responseCode = connection.getResponseCode();
	InputStream inputStream;
	if (200 <= responseCode && responseCode <= 299) {
		inputStream = connection.getInputStream();
	} else {
		inputStream = connection.getErrorStream();
	}
	BufferedReader in = new BufferedReader(
	new InputStreamReader(
	inputStream));
	StringBuilder response = new StringBuilder();
	String currentLine;
	while ((currentLine = in.readLine()) != null)
		response.append(currentLine);
	in.close();
	return response.toString();
}
public static String getClipboardString() {
	Toolkit kit = Toolkit.getDefaultToolkit();
	Clipboard clip = kit.getSystemClipboard();
	try {
		return (String) clip.getData(DataFlavor.stringFlavor);
	} catch (UnsupportedFlavorException e) {
		return null;
	} catch (IOException e) {
		return null;
	}
}

public static void setClipboardString(String str) {
	Toolkit kit = Toolkit.getDefaultToolkit();
	Clipboard clip = kit.getSystemClipboard();
	StringSelection ss = new StringSelection(str);
	clip.setContents(ss, ss);
}
