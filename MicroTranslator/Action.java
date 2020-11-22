package MicroTranslator;
import MicroTranslator.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JTextField;
import javax.swing.JComboBox;
import javax.swing.JCheckBox;

public class Action implements ActionListener{
	public MicroTranslator m;
	Action(MicroTranslator mt){m=mt;}
	public void actionPerformed(ActionEvent e){
		if(e.getSource() instanceof JButton) buttonAction(e);
		if (e.getSource() instanceof JTextField) textFieldAction(e);
		if (e.getSource() instanceof JComboBox) comboBoxAction(e);
		if (e.getSource() instanceof JCheckBox) checkBoxAction(e);
	}
	
	private void buttonAction(ActionEvent e){
		JButton b = (JButton)e.getSource();
		if(b==m.transButtonMain)m.transField.setText(m.trans.translate(m.textField.getText(),m.TRANS_LANG_LIST[m.langComboxMain.getSelectedIndex()]));
		if(b==m.transButtonBig)m.transArea.setText(m.trans.translate(m.textArea.getText(),m.TRANS_LANG_LIST[m.langComboxBig.getSelectedIndex()]));
	}
	
	private void textFieldAction(ActionEvent e){
		JTextField tf = (JTextField)e.getSource();
		if(tf == m.textField)m.transField.setText(m.trans.translate(m.textField.getText(),m.TRANS_LANG_LIST[m.langComboxMain.getSelectedIndex()]));
	}
	private void comboBoxAction(ActionEvent e){
	}
	private void checkBoxAction(ActionEvent e){
		JCheckBox cb = (JCheckBox)e.getSource();
		if(cb == m.selectAll)m.isSelectAll=m.selectAll.isSelected();
		if(cb == m.alwaysTop)m.setAlwaysOnTop(m.alwaysTop.isSelected());
	}
}