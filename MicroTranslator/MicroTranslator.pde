import java.io.IOException;
import java.io.InputStreamReader;

import java.net.URLEncoder;
import java.net.HttpURLConnection;
import java.net.URL;

import java.awt.Canvas;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusAdapter;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;

import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;
import javax.swing.JLayeredPane;
import javax.swing.JTextField;
import javax.swing.JPopupMenu;
import javax.swing.JMenuItem;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

static final String COPY = "コピー";
static final String PASTE = "ペースト";
static final String TITLE = "Micro Translator";
static final String EXE_ICON = "translator2.png";
static final String BUTTON_ICON = "translator.png";
static final String URL_TEXT = "url.txt";
static final String BEFOR_TRANS = "翻訳前";
static final String AFTER_TRANS = "翻訳後";

JLayeredPane pane;
JTextField trans;
JTextField text;
JPopupMenu textmenu = new JPopupMenu();
JPopupMenu transmenu = new JPopupMenu();
JMenuItem textcopy = new JMenuItem(COPY);
JMenuItem transcopy = new JMenuItem(COPY);
JMenuItem textpaste = new JMenuItem(PASTE);
String[] urls;
String url;
void setup() {
	size(200, 190);
	surface.setAlwaysOnTop(true);
	surface.setTitle(TITLE);
	PImage exeIcon = loadImage(EXE_ICON);
	surface.setIcon(exeIcon);
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
	urls=loadStrings(URL_TEXT);
	url=urls[0];
	Pattern p = Pattern.compile("^https?://[a-zA-Z0-9/:%#&~=_!'\\$\\?\\(\\)\\.\\+\\*\\-]+$");
	Matcher m = p.matcher(url);
	if(!m.find()){
		println(m.find());
		exit();
		println(m.find());
	}
	fill(255,50,20);
	PImage buttonImage =loadImage(BUTTON_ICON);
	image(buttonImage,50,50,100,100);
	text(BEFOR_TRANS,0,10);
	text(AFTER_TRANS,0,140);
	thread("firstTrans");
}

void draw(){
	
}

void mousePressed(){
	println("aa");
  try{
    text.setText(getClipboardString());
    trans.setText(getText(url+URLEncoder.encode(getClipboardString(), "UTF-8")));
    setClipboardString(trans.getText());
  }catch(IOException e){
  }
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
	inputStream,"UTF-8"));
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


class myListener implements ActionListener{
  void actionPerformed(ActionEvent e){
    JMenuItem mi = (JMenuItem)e.getSource();
    if(mi==textcopy) setClipboardString(text.getText());
    if(mi==transcopy) setClipboardString(trans.getText());
    if(mi==textpaste) text.setText(getClipboardString());
  }
}

ActionListener enterActionListener = new ActionListener() {
  @Override
  void actionPerformed(ActionEvent e) {
    translate();
  }
};
