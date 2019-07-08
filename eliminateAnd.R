Elektronidex<-read.csv("A:/B/Ubiqum/module2/associations/ElectronidexTransactions2017.csv",
                       header = FALSE, stringsAsFactors = FALSE)

#eliminate "and" from the dataset

#Elektronidex[Elektronidex=="and"]<-""
Elektronidex[Elektronidex==
               "Logitech MK550 Wireless Wave Keyboard and Mouse Combo"]<-"Logitech MK550"
Elektronidex[Elektronidex==
               "Logitech Desktop MK120 Mouse and keyboard Combo"]<-"Logitech MK120"
Elektronidex[Elektronidex==
               "Logitech MK270 Wireless Keyboard and Mouse Combo"]<-"Logitech MK270"
Elektronidex[Elektronidex==
               "EagleTec Wireless Combo Keyboard and Mouse"]<-"EagleTec Wireless Combo"
Elektronidex[Elektronidex==
               "Microsoft Wireless Comfort Keyboard and Mouse"]<-"Microsoft Wireless Comfort"
Elektronidex[Elektronidex==
               "Microsoft Wireless Desktop Keyboard and Mouse"]<-"Microsoft Wireless Desktop"
Elektronidex[Elektronidex==
               "Logitech MK360 Wireless Keyboard and Mouse Combo"]<-"Logitech MK360"
Elektronidex[Elektronidex==
               "Microsoft Office Home and Student 2016"]<-"Microsoft Office 2016"

write.table(Elektronidex, file="A:/B/Ubiqum/module2/associations/withoutAnd.csv",
            col.names = FALSE, row.names = FALSE, sep=",")
#import transactions dataset
Elektro<-
  read.transactions("A:/B/Ubiqum/module2/associations/withoutAnd.csv",format = c("basket"),
                    rm.duplicates = TRUE, sep=",")