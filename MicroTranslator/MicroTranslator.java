import java.io.IOException;

import java.io.BufferedOutputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.InputStream;

import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLEncoder;

import javax.swing.JFrame;
import javax.swing.JButton;
import javax.swing.ImageIcon;

import java.awt.Container;
import java.awt.Color;
import java.awt.BorderLayout;

@SuppressWarnings("serial")
public class MicroTranslator extends JFrame{
	BigMode bigPane = new BigMode();
	public Container contentPane;
	public static void main(String[] args) {
		MicroTranslator trans = new MicroTranslator("test");
		trans.setVisible(true);
		trans.myMain();
	}

	public MicroTranslator(String title){
		setTitle(title);
		setSize(200,225);
		setLocationRelativeTo(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		contentPane = getContentPane();
	}

	public void myMain(){
		contentPane.setBackground(Color.GREEN);
		
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
