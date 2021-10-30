public class AccountTriggerHelper {
    public static void formatPhone(Account account){
        //Another commit on feature branch
        String areaCode = account.phone.substring(0,2);
        String dotNumber = account.phone.substring(2,3);
        String firstPart = account.phone.substring(3,7);
        String secondPart = account.phone.substring(7);

        account.phone = String.format('({0}){1}.{2}-{3}', new List<Object>{areaCode, dotNumber, firstPart, secondPart});
    }
}