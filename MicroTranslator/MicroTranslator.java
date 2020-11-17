import java.io.IOException;

import java.io.BufferedOutputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.InputStream;

import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLEncoder;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JButton;
import javax.swing.ImageIcon;
import javax.swing.JTextField;
import javax.swing.JTextArea;

import java.awt.Container;
import java.awt.Color;
import java.awt.BorderLayout;
import java.awt.Insets;
import java.awt.Dimension;


@SuppressWarnings("serial")
public class MicroTranslator extends JFrame{
	
	static final Color BACKGROUND_COLOR = new Color(50,50,50);
	static final Color TEXT_BACKGROUND_COLOR = new Color(80,80,80);
	static final Color TEXT_COLOR = new Color(250,250,250);
	static final Color FOREGROUND_COLOR = new Color(250,250,250);
	
	
	// BigMode bigPane = new BigMode();
	Translate trans = new Translate("https://script.google.com/macros/s/AKfycbzlq6vwO3tljMLjPg6l2nU4IetxueScBmN9RU4n3dm4rl6_4Wg/exec?text=");
	public Container contentPane;
	public static void main(String[] args) {
		MicroTranslator mainFrame = new MicroTranslator("test");
		mainFrame.setVisible(true);
		mainFrame.myMain();
	}

	public MicroTranslator(String title){
		setTitle(title);
		setSize(200,225);
		getContentPane().setPreferredSize(new Dimension(200, 225));
		pack();
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setAlwaysOnTop(true);
		contentPane = getContentPane();
		
		JPanel mainPane = new JPanel();
		JPanel bigPane = new JPanel();
		JTextField textField = new JTextField();
		JTextField transField = new JTextField();
		JTextArea textArea = new JTextArea();
		JTextArea transArea = new JTextArea();
		JButton transButtonMain = new JButton("trans");
		JButton transButtonBig = new JButton("trans");
		
		mainPane.setLayout(null);
		bigPane.setLayout(null);
		
		mainPane.add(transButtonMain);
		mainPane.add(textField);
		mainPane.add(transField);
		bigPane.add(transButtonBig);
		bigPane.add(textArea);
		bigPane.add(transArea);
		
		contentPane.add(bigPane);
		contentPane.add(mainPane);
		
		bigPane.setBounds(0,0,200,225);
		mainPane.setBounds(0,0,200,225);
		
		textField.setBounds(10,13,180,30);
		transField.setBounds(10,185,180,30);
		textArea.setBounds(10,13,480,125);
		transArea.setBounds(10,165,480,125);
		transButtonMain.setBounds(150,45,40,25);
		transButtonMain.setMargin(new Insets(0,0,0,0));
		
		textField.setBackground(TEXT_BACKGROUND_COLOR);
		transField.setBackground(TEXT_BACKGROUND_COLOR);
		transButtonMain.setBackground(BACKGROUND_COLOR);
		textField.setForeground(TEXT_COLOR);
		transField.setForeground(TEXT_COLOR);
		transButtonMain.setForeground(FOREGROUND_COLOR);
		
		mainPane.setOpaque(false);
		bigPane.setOpaque(false);
		mainPane.setVisible(true);
		bigPane.setVisible(false);
		
	}

	public void myMain(){
		contentPane.setBackground(BACKGROUND_COLOR);
	}
}

class Translate{
	String url;
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
			sendUrl=url+text+"&target="+language;
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
