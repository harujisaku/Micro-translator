import java.io.IOException;
import java.io.InputStreamReader;
import java.awt.datatransfer.UnsupportedFlavorException;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;

import java.net.URLEncoder;
import java.net.HttpURLConnection;
import java.net.URL;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Properties;

import java.awt.Canvas;
import java.awt.Toolkit;
import java.awt.Color;
import java.awt.Insets;
import java.awt.Container;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusAdapter;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.DataFlavor;

import javax.swing.JMenuItem;
import javax.swing.JPopupMenu;
import javax.swing.JLayeredPane;
import javax.swing.JTextField;
import javax.swing.JComboBox;
import javax.swing.JButton;
import javax.swing.JTextArea;
import javax.swing.JScrollPane;
import javax.swing.JCheckBox;


static final String COPY = "コピー,copy";
static final String PASTE = "ペースト,paste";
static final String TITLE = "Micro Translator";
static final String EXE_ICON = "translator2.png";
static final String URL_TEXT = "url.txt";
static final String BEFOR_TRANS = "before";
static final String AFTER_TRANS = "after";
static final String TRANS_TO = "trans to";
static final String TRANS_BUTTON = "trans";
static final String RETURN_LINE = System.getProperty("line.separator");
static final String SELECT_ALL_CHECKBOX = "select all";
static final String ALWAYS_TOP_CHECKBOX = "always Top";
static final int BUTTON_POS_X = 0;
static final int BUTTON_POS_Y = 65;
static final Color BACKGROUND_COLOR = new Color(50,50,50);
static final Color TEXT_BACKGROUND_COLOR = new Color(80,80,80);
static final Color FOREGROUND_COLOR = new Color(250,250,250);

boolean isBigger = false;
boolean isBigged = false;
boolean wantBig = false;
boolean isAlwaysTop;
boolean isSelectAll;
String url;
String[] fontList = PFont.list();
String[] langList ={"Japanese","English","French","Russian","Italian"};
String[] langLists ={"ja","en","fr","ru","it"};
PFont fontG;
PFont fontM;

JLayeredPane pane;
JScrollPane textPane;
JScrollPane transPane;
JTextField trans;
JTextField text;
JTextArea textArea;
JTextArea transArea;
JPopupMenu textmenu = new JPopupMenu();
JPopupMenu transmenu = new JPopupMenu();
JMenuItem textcopy = new JMenuItem(COPY);
JMenuItem transcopy = new JMenuItem(COPY);
JMenuItem textpaste = new JMenuItem(PASTE);
JComboBox langCombox = new JComboBox(langList);
JButton transButton = new JButton(TRANS_BUTTON);
JCheckBox selectAll;
JCheckBox alwaysTop;
Properties p;

void setup() {
	size(200, 225);
	windowSetting();
	loadConfig();
	Pattern p = Pattern.compile("^https?://[a-zA-Z0-9/:%#&~=_!'\\$\\?\\(\\)\\.\\+\\*\\-]+$");
	Matcher m = p.matcher(url);
	if(!m.find()){
		exit();
	}
	fontG=createFont("SansSerif",90.0);
	fontM=createFont("Serif",90.0);
	drawButton();
}

void draw(){
	background(BACKGROUND_COLOR.getRed(),BACKGROUND_COLOR.getGreen(),BACKGROUND_COLOR.getBlue());
	if((text.getText().length()>15&&!isBigger)||wantBig){
		surface.setSize(500,300);
		textArea = new JTextArea(text.getText());
		transArea = new JTextArea(trans.getText());
		textPane = new JScrollPane(textArea);
		transPane = new JScrollPane(transArea);
		selectAll = new JCheckBox(SELECT_ALL_CHECKBOX,isSelectAll);
		alwaysTop = new JCheckBox(ALWAYS_TOP_CHECKBOX,isAlwaysTop);
		textPane.setBounds(10,13,480,125);
		transPane.setBounds(10,165,480,125);
		textArea.setBounds(10,13,480,125);
		transArea.setBounds(10,165,480,125);
		textArea.setBackground(TEXT_BACKGROUND_COLOR);
		transArea.setBackground(TEXT_BACKGROUND_COLOR);
		textArea.setForeground(FOREGROUND_COLOR);
		transArea.setForeground(FOREGROUND_COLOR);
		langCombox.setBounds(90,139,100,25);
		transButton.setBounds(190,139,50,25);
		textArea.setCaretColor(new Color(82,139,255));
		transArea.setCaretColor(new Color(82,139,255));
		textArea.setComponentPopupMenu(textmenu);
		transArea.setComponentPopupMenu(transmenu);
		transArea.setEditable(false);
		selectAll.setBounds(240,139,100,25);
		selectAll.setBackground(BACKGROUND_COLOR);
		selectAll.setForeground(FOREGROUND_COLOR);
		selectAll.addActionListener(new CheckAction());
		alwaysTop.setBounds(340,139,100,25);
		alwaysTop.setBackground(BACKGROUND_COLOR);
		alwaysTop.setForeground(FOREGROUND_COLOR);
		alwaysTop.addActionListener(new CheckAction());
		pane.remove(text);
		pane.remove(trans);
		pane.add(textPane);
		pane.add(transPane);
		pane.add(selectAll);
		pane.add(alwaysTop);
		textArea.requestFocus();
		textArea.setCaretPosition(textArea.getText().length());
		delay(10);
		isBigger=true;
		return;
	}else if(isBigger&&!isBigged){
		delay(100);
		textArea.addFocusListener(new FocusAdapter() {
			@Override public void focusGained(FocusEvent e) {
				if(!selectAll.isSelected()) return;
				((JTextArea) e.getComponent()).selectAll();
			}
		});
		transArea.addFocusListener(new FocusAdapter() {
			@Override public void focusGained(FocusEvent e) {
				if(!selectAll.isSelected()) return;
				((JTextArea) e.getComponent()).selectAll();
			}
		});
		isBigged=true;
	}else if(isBigger&&isBigged){
		drawButton();
		delay(100);
		return;
	}
	drawButton();
}

void mousePressed(){
	if(!isBigger){
		try{
			if(getClipboardString()!=null){
				text.setText(getClipboardString());
				trans.setText(getText(url+URLEncoder.encode(getClipboardString(), "UTF-8")+"&target="+langLists[langCombox.getSelectedIndex()]));
				setClipboardString(trans.getText());
			}
		}catch(IOException e){
		}catch(NullPointerException e){
		}
	}
}

void translate(){
	if(text.getText()!=null){
			if(isBigger){
				transArea.setText(translateForGoogleAPI(textArea.getText()));
				return;
			}
		trans.setText(translateForGoogleAPI(text.getText()));
	}
}

void windowSetting(){
	surface.setAlwaysOnTop(true);
	surface.setTitle(TITLE);
	background(BACKGROUND_COLOR.getRed(),BACKGROUND_COLOR.getGreen(),BACKGROUND_COLOR.getBlue());
	PImage exeIcon = loadImage(EXE_ICON);
	surface.setIcon(exeIcon);
	Canvas canvas = (Canvas) surface.getNative();
	pane = (JLayeredPane) canvas.getParent().getParent();
	text = new JTextField();
	trans = new JTextField();
	text.addActionListener(enterActionListener);
	trans.setEditable(false);
	text.setBounds(10, 13, 180, 30);
	trans.setBounds(10, 185, 180, 30);
	text.setBackground(TEXT_BACKGROUND_COLOR);
	trans.setBackground(TEXT_BACKGROUND_COLOR);
	text.setForeground(FOREGROUND_COLOR);
	trans.setForeground(FOREGROUND_COLOR);
	text.setCaretColor(new Color(82,139,255));
	trans.setCaretColor(new Color(82,139,255));
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
	langCombox.setBounds(50,45,100,25);
	langCombox.setBackground(TEXT_BACKGROUND_COLOR);
	langCombox.setForeground(FOREGROUND_COLOR);
	transButton.addActionListener(new ActionListener() {
	public void actionPerformed(ActionEvent e) {
		translate();
	}});
	transButton.setBounds(150,45,40,25);
	transButton.setMargin(new Insets(0,0,0,0));
	transButton.setBackground(BACKGROUND_COLOR);
	transButton.setForeground(FOREGROUND_COLOR);
	pane.add(text);
	pane.add(trans);
	pane.add(langCombox);
	pane.add(transButton);
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
}

void drawButton(){
	if(!isBigger){
		textAlign(LEFT,TOP);
		textSize(90.0);
		textFont(fontM,90.0);
		fill(FOREGROUND_COLOR.getRed(),FOREGROUND_COLOR.getGreen(),FOREGROUND_COLOR.getBlue());
		text("あ",BUTTON_POS_X+20,BUTTON_POS_Y);
		textFont(fontG,90.0);
		text("↓  /A",BUTTON_POS_X-30,BUTTON_POS_Y);
		textSize(13.0);
		text(BEFOR_TRANS,10,-3);
		text(TRANS_TO,5,45);
		text(AFTER_TRANS,10,BUTTON_POS_Y+100);
		return;
	}
	textSize(13.0);
	text(BEFOR_TRANS,10,-3);
	text(TRANS_TO,40,142);
	text(AFTER_TRANS,10,142);
}

void writeConfig(){
	FileWriter file  = null;
	try {
		file = new FileWriter(dataPath("")+"\\MicroTranslator.properties");
		p = new Properties();

		p.setProperty("alwaysTop", String.valueOf(alwaysTop.isSelected()));
		p.setProperty("selectAll", String.valueOf(selectAll.isSelected()));
		p.store(file, "config");

	}catch (Exception e) {
		System.out.println(e.getMessage());
	}finally {
		if(file != null) {
			try {
				file.close();
			}catch(Exception e) {
				System.out.println(e.getMessage());
			}
		}
	}
}

import java.io.FileReader;
import java.util.Properties;
void loadConfig(){
	FileReader file  = null;
		try {
			file = new FileReader(dataPath("")+"\\MicroTranslator.properties");
			Properties p = new Properties();
			p.load(file);
			isAlwaysTop=Boolean.valueOf(p.getProperty("alwaysTop"));
			isSelectAll=Boolean.valueOf(p.getProperty("selectAll"));
			url=p.getProperty("url");
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			if(file != null) {
				try {
					file.close();
				}catch(Exception e) {
				System.out.println(e.getMessage());
			}
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
		if(!isBigger){
			if(mi==textcopy) text.copy();
			if(mi==transcopy) trans.copy();
			if(mi==textpaste) text.paste();
		}else{
			if(mi==textcopy) textArea.copy();
			if(mi==transcopy) transArea.copy();
			if(mi==textpaste) textArea.paste();
		}
	}
}

class CheckAction implements ActionListener {
	@Override
	public void actionPerformed(ActionEvent e) {
		JCheckBox ce = (JCheckBox)e.getSource();
		if(ce==alwaysTop) surface.setAlwaysOnTop(alwaysTop.isSelected());
		if(ce==selectAll) ;
		writeConfig();
	}
}

ActionListener enterActionListener = new ActionListener() {
	@Override
	void actionPerformed(ActionEvent e) {
		translate();
	}
};

String translateForGoogleAPI(String text){
	try{
		text = text.replace("\n","<rl>");
		text = text.replace("<nt>","<span translate=\"no\">");
		text = text.replace("</nt>","</span>");
		String transedText = getText(url+URLEncoder.encode(text, "UTF-8")+"&target="+langLists[langCombox.getSelectedIndex()]);
		transedText = transedText.replace("<span translate=\"no\">","");
		transedText = transedText.replace("</span>","");
		transedText = transedText.replace("<rl>",System.lineSeparator());
		return transedText;
	}catch(IOException e){
		return null;
	}
}
