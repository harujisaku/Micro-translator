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

JLayeredPane pane;
JTextField trans;
JTextField text;
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
	pane.add(text);
	pane.add(trans);
	fill(255,50,20);
	PImage icon =loadImage("translator.png");
	image(icon,50,50,100,100);
	text("翻訳前",0,10);
	text("翻訳後",0,140);
	thread("firstTrans");
}
private ActionListener enterActionListener = new ActionListener() {
	@Override
	public void actionPerformed(ActionEvent e) {
		mousePressed();
	}
};

void draw() {
}

void firstTrans(){
	text.setText("hello world");
	mousePressed();
}

void mousePressed(){
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
	inputStream));
	StringBuilder response = new StringBuilder();
	String currentLine;
	while ((currentLine = in.readLine()) != null)
		response.append(currentLine);
	in.close();
	return response.toString();
}
