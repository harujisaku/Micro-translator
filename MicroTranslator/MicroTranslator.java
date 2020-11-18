import java.io.IOException;

import java.io.BufferedOutputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.InputStream;

import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLEncoder;

import java.awt.Container;
import java.awt.Color;
import java.awt.BorderLayout;
import java.awt.Insets;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.FocusAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.KeyAdapter;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.datatransfer.DataFlavor;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import javax.swing.JTextArea;
import javax.swing.JComboBox;
import javax.swing.JCheckBox;

@SuppressWarnings("serial")
public class MicroTranslator extends JFrame{
	
	static final String[] LANG_LIST = {"Japanese","English","French","Russian","Italian"};
	static final String[] TRANS_LANG_LIST ={"ja","en","fr","ru","it"};
	static final String AFTER_TEXT = "after";
	static final String BEFORE_TEXT = "before";
	static final String TRANS_TO_TEXT = "trans to";
	static final String ALWAYS_TOP_CHECKBOX = "always top";
	static final String SELECT_ALL_CHECKBOX = "select All";
	static final Color BACKGROUND_COLOR = new Color(50,50,50);
	static final Color TEXT_BACKGROUND_COLOR = new Color(80,80,80);
	static final Color TEXT_COLOR = new Color(250,250,250);
	static final Color FOREGROUND_COLOR = new Color(250,250,250);
	static final Color CARET_COLOR = new Color(82,139,255);
	boolean canSelectAll = true;
	
	Translate trans = new Translate("https://script.google.com/macros/s/AKfycbzlq6vwO3tljMLjPg6l2nU4IetxueScBmN9RU4n3dm4rl6_4Wg/exec?text=");
	public Container contentPane;
	public static void main(String[] args) {
		MicroTranslator mainFrame = new MicroTranslator("test");
		mainFrame.setVisible(true);
		mainFrame.myMain();
	}

	public MicroTranslator(String title){
		setTitle(title);
		getContentPane().setPreferredSize(new Dimension(200, 225));
		pack();
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setAlwaysOnTop(true);
		contentPane = getContentPane();
		
		JPanel mainPane = new JPanel();
		JPanel bigPane = new JPanel();
		JLabel afterTransMain = new JLabel(AFTER_TEXT);
		JLabel beforeTransMain = new JLabel(BEFORE_TEXT);
		JLabel afterTransBig = new JLabel(AFTER_TEXT);
		JLabel beforeTransBig = new JLabel(BEFORE_TEXT);
		JLabel transToMain = new JLabel(TRANS_TO_TEXT);
		JLabel transToBig = new JLabel(TRANS_TO_TEXT);
		JTextField textField = new JTextField();
		JTextField transField = new JTextField();
		JTextArea textArea = new JTextArea();
		JTextArea transArea = new JTextArea();
		JButton transButtonMain = new JButton("trans");
		JButton transButtonBig = new JButton("trans");
		JComboBox langComboxMain = new JComboBox(LANG_LIST);
		JComboBox langComboxBig = new JComboBox(LANG_LIST);
		JCheckBox selectAll = new JCheckBox(SELECT_ALL_CHECKBOX);
		JCheckBox alwaysTop = new JCheckBox(ALWAYS_TOP_CHECKBOX);
		
		mainPane.setLayout(null);
		bigPane.setLayout(null);
		
		mainPane.add(transButtonMain);
		mainPane.add(textField);
		mainPane.add(transField);
		mainPane.add(langComboxMain);
		mainPane.add(afterTransMain);
		mainPane.add(beforeTransMain);
		mainPane.add(transToMain);
		
		bigPane.add(transButtonBig);
		bigPane.add(textArea);
		bigPane.add(transArea);
		bigPane.add(langComboxBig);
		bigPane.add(afterTransBig);
		bigPane.add(beforeTransBig);
		bigPane.add(transToBig);
		bigPane.add(alwaysTop);
		bigPane.add(selectAll);
		
		// contentPane.add(bigPane);
		contentPane.add(mainPane);
		
		bigPane.setBounds(0,0,500,300);
		mainPane.setBounds(0,0,200,225);
		
		textField.setBounds(10,13,180,30);
		transField.setBounds(10,185,180,30);
		textArea.setBounds(10,13,480,125);
		transArea.setBounds(10,165,480,125);
		afterTransMain.setBounds(10,0,100,10);
		afterTransBig.setBounds(10,152,100,10);
		beforeTransBig.setBounds(10,0,100,10);
		beforeTransMain.setBounds(10,170,100,10);
		transToMain.setBounds(5,48,100,10);
		transToBig.setBounds(40,145,100,10);
		langComboxMain.setBounds(50,45,100,25);
		langComboxBig.setBounds(90,139,100,25);
		alwaysTop.setBounds(340,139,100,25);
		selectAll.setBounds(240,139,100,25);
		transButtonMain.setBounds(150,45,40,25);
		transButtonBig.setBounds(190,139,50,25);
		transButtonMain.setMargin(new Insets(0,0,0,0));
		transButtonBig.setMargin(new Insets(0,0,0,0));
		
		textField.setBackground(TEXT_BACKGROUND_COLOR);
		transField.setBackground(TEXT_BACKGROUND_COLOR);
		transButtonMain.setBackground(BACKGROUND_COLOR);
		transButtonBig.setBackground(BACKGROUND_COLOR);
		textField.setForeground(TEXT_COLOR);
		transField.setForeground(TEXT_COLOR);
		textField.setCaretColor(CARET_COLOR);
		transField.setCaretColor(CARET_COLOR);
		textArea.setBackground(TEXT_BACKGROUND_COLOR);
		textArea.setForeground(TEXT_COLOR);
		textArea.setCaretColor(CARET_COLOR);
		transArea.setBackground(TEXT_BACKGROUND_COLOR);
		transArea.setForeground(TEXT_COLOR);
		transArea.setCaretColor(CARET_COLOR);
		transButtonMain.setForeground(FOREGROUND_COLOR);
		transButtonBig.setForeground(FOREGROUND_COLOR);
		afterTransMain.setForeground(TEXT_COLOR);
		beforeTransMain.setForeground(TEXT_COLOR);
		afterTransBig.setForeground(TEXT_COLOR);
		beforeTransBig.setForeground(TEXT_COLOR);
		transToMain.setForeground(TEXT_COLOR);
		transToBig.setForeground(TEXT_COLOR);
		langComboxMain.setBackground(TEXT_BACKGROUND_COLOR);
		langComboxBig.setBackground(TEXT_BACKGROUND_COLOR);
		langComboxMain.setForeground(TEXT_COLOR);
		langComboxBig.setForeground(TEXT_COLOR);
		selectAll.setBackground(BACKGROUND_COLOR);
		selectAll.setForeground(TEXT_COLOR);
		alwaysTop.setBackground(BACKGROUND_COLOR);
		alwaysTop.setForeground(TEXT_COLOR);
		
		transButtonMain.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				transField.setText(trans.translate(textField.getText(),TRANS_LANG_LIST[langComboxMain.getSelectedIndex()]));
		}});
		transButtonBig.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e) {
				transArea.setText(trans.translate(textArea.getText(),TRANS_LANG_LIST[langComboxBig.getSelectedIndex()]));
		}});
		textField.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				transField.setText(trans.translate(textField.getText(),TRANS_LANG_LIST[langComboxMain.getSelectedIndex()]));
		}});
		textField.addFocusListener(new FocusAdapter() {
			public void focusGained(FocusEvent e) {
				if(!canSelectAll) return;
				textField.selectAll();
		}});
		transField.addFocusListener(new FocusAdapter() {
			public void focusGained(FocusEvent e) {
				if(!canSelectAll) return;
				transField.selectAll();
		}});
		textArea.addFocusListener(new FocusAdapter() {
			public void focusGained(FocusEvent e) {
				if(!canSelectAll) return;
				textArea.selectAll();
		}});
		transArea.addFocusListener(new FocusAdapter() {
			public void focusGained(FocusEvent e) {
				if(!canSelectAll){
					canSelectAll=true;
					return;
				}
				textArea.selectAll();
		}});
		textArea.addKeyListener(new KeyAdapter(){
			public void keyReleased(KeyEvent e){
				if(textArea.getText().length()<15){
					textField.setText(textArea.getText());
					contentPane.removeAll();
					contentPane.add(mainPane);
					getContentPane().setPreferredSize(new Dimension(200, 225));
					pack();
					canSelectAll=false;
					textField.requestFocus();
					textField.setCaretPosition(textArea.getCaretPosition());
					langComboxMain.setSelectedIndex(langComboxBig.getSelectedIndex());
		}}});
		textField.addKeyListener(new KeyAdapter(){
			public void keyReleased(KeyEvent e){
				if(textField.getText().length()>=15){
					textArea.setText(textField.getText());
					contentPane.removeAll();
					contentPane.add(bigPane);
					getContentPane().setPreferredSize(new Dimension(500, 300));
					pack();
					canSelectAll=false;
					textArea.requestFocus();
					textArea.setCaretPosition(textField.getCaretPosition());
					langComboxBig.setSelectedIndex(langComboxMain.getSelectedIndex());
		}}});
		transField.setEditable(false);
		transArea.setEditable(false);
		
		mainPane.setOpaque(false);
		bigPane.setOpaque(false);
		mainPane.setVisible(true);
		bigPane.setVisible(true);
		
		
	}

	public void myMain(){
		contentPane.setBackground(BACKGROUND_COLOR);
	}
}
class Translate{
	String url;
	String defaultLanguage = "en";
	GoogleTranslate googleTranslate;
	public Translate(String url){
		this.url=url;
		googleTranslate = new GoogleTranslate(url);
	}

	public String translate(String text,String language){
		String transedString = "failed!";
		try {
			transedString = googleTranslate.getString(text,language);
		} catch(IOException e) {
			System.out.println(e.getMessage());
		}
		return transedString;
	}

	public String translate(String text){
		return translate(text,defaultLanguage);
	}

	public String replaceToTag(String text){
		//改行と<br>タグを<rl>に置換、<nt>タグを<span translate="no">に置換
		return text.replace("\n","<rl>").replace("</br>","<rl>").replace("<br>","<rl>").replace("<nt>","<span translate=\"no\">").replace("</nt>","</span>");
	}

	public String replaceFromTag(String text){
		return text.replace("<rl>","\n").replace("<span translate=\"no\">","").replace("</span>","");
	}

	class GoogleTranslate{

		String url,language,sendUrl;
		HttpURLConnection connection;
		int responseCode;

		GoogleTranslate(String url){
			this.url=url;
		}

		String getString(String text,String language) throws IOException {
			this.language=language;
			sendUrl=url+URLEncoder.encode(text,"UTF-8")+"&target="+language;
			connection = (HttpURLConnection) new URL(sendUrl).openConnection();
			responseCode = connection.getResponseCode();
			InputStream inputStream;
			if(200 <= responseCode && responseCode <= 299) {
				inputStream = connection.getInputStream();
			}else{
				inputStream = connection.getErrorStream();
			}
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream,"UTF-8"));
			StringBuilder response = new StringBuilder();
			String currentLine;
			while ((currentLine = in.readLine()) != null)
				response.append(currentLine);
			in.close();
			return response.toString();
		}
	}
}
