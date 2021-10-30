public class ClassDebug {
    public Account acc;

    public void showAcc(){
        List<Account> accList = [SELECT Id, Name FROM Account LIMIT 5];
        this.acc = accList[0];

        System.debug(acc);
    }
}