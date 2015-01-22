public class UtilitiesController {

public boolean RunMDWReportInitated {get; set;}

public UtilitiesController (){
RunMDWReportInitated = false;
}

public void InitateMUMReport(){


BatchClass_MDwReportGeneration MDWObj  = new BatchClass_MDwReportGeneration ();
Database.executeBatch(MDWObj  );
RunMDWReportInitated = true;


}

}