package MicroTranslator;
import MicroTranslator.*;
import java.io.IOException;

import java.io.BufferedOutputStream;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.InputStream;

import java.net.URL;
import java.net.HttpURLConnection;
import java.net.URLEncoder;

public class Translate{
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
			text = replaceToTag(text);
			transedString = googleTranslate.getString(text,language);
			transedString = replaceFromTag(transedString);
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
