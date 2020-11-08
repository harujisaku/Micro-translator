import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
String a="apple";
import javax.swing.*;
import java.awt.*;

JLayeredPane pane;
JTextField trans;
JTextField text;
JTextArea area;

void setup() {
  size(200, 200);

  // SmoothCanvasの親の親にあたるJLayeredPaneを取得
  Canvas canvas = (Canvas) surface.getNative();
  pane = (JLayeredPane) canvas.getParent().getParent();

  // 1行のみのテキストボックスを作成
  text = new JTextField();
  text.setBounds(10, 10, 150, 30);
  pane.add(text);

  trans = new JTextField();
  trans.setBounds(10, 150, 150, 30);
  pane.add(trans);
}

void draw() {
  // println( field.getText() +","+ area.getText() );
}

void keyPressed() {
	if (keyCode==ENTER) {
		println("translate");
		trans.setText(translate(text.getText()));
	}
}

void mousePressed(){
	println("translate");
	trans.setText(translate(text.getText()));
}

String translate(String word){
	Charset charset = StandardCharsets.UTF_8;

	CloseableHttpClient httpclient =HttpClients.createDefault();
	HttpGet request = new HttpGet("https://script.google.com/macros/s/AKfycbzvbsjOnmB22F4n7hdaEYwRAXnHlIVKgZhv_Rsdg4-Qylo8qw/exec?word="+word);
	CloseableHttpResponse response = null;
	String responseData=null;
	try {
		response = httpclient.execute(request);
		int status = response.getStatusLine().getStatusCode();
		if (status == HttpStatus.SC_OK){
			responseData =
				EntityUtils.toString(response.getEntity(),charset);
			System.out.println(responseData);
			return responseData;
		}
	} catch (ClientProtocolException e) {
			e.printStackTrace();
	} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
	} catch (IOException e) {
			e.printStackTrace();
	} finally {
		try {
			if (response != null) {
				response.close();
			}
			if (httpclient != null) {
				httpclient.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	return responseData;
}
