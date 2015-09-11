
  PROGRAM

OMIT('***')
 * Created with Clarion 10.0
 * User: Jim Allen
 * Date: 9/9/2015
 * Time: 3:43 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 ***

                    MAP
ParseCommand            PROCEDURE(STRING eiCommand)
GetSetupString          FUNCTION(STRING fileName), STRING
SaveSetupString         FUNCTION(STRING fileName, string newSetupString)
                    


                    END



    INCLUDE('equates.clw'),ONCE 


    
        


selectedCommand       CSTRING(512)
responseOut         CSTRING(64000)
SetupString         CSTRING(64000)
SetupStringBuffer       CSTRING(64000)



DestName  STRING(FILE:MaxFilePath)

 
LineSize    EQUATE(64000)

FileIndent  EQUATE(20)


DestFile  FILE,DRIVER('ASCII'),CREATE,NAME(DestName)

Record     RECORD

Line        STRING(LineSize)

            END
            END



    




!FILELABEL           DOS,ASCII,NAME('TEST.ASC')



MyWindow            WINDOW('Clarion POS'),AT(,,609,330),GRAY,FONT('MS Sans Serif',8,,FONT:regular)
                        OLE,AT(3,2,24,7),USE(?OLE1),HIDE,COMPATIBILITY(021H),CREATE('cipwin32.Ea' & |
                            'syIntegrator')
                        END
                        SHEET,AT(21,86,532,217),USE(?SHEET1)
                            TAB('Trans Fields'),USE(?TAB1)
                                TEXT,AT(133,124,93,12),USE(?AMOUNTTOTAL)
                                STRING('AmountTotal'),AT(46,124,,14),USE(?STRING1),FONT('Microso' & |
                                    'ft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Cashier'),AT(46,142,61,14),USE(?STRING1:2),FONT('Microso' & |
                                    'ft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(133,142,93,12),USE(?CASHIER)
                                TEXT,AT(133,159,93,12),USE(?UNIQUETRANSREF)
                                STRING('UniqueTransRef'),AT(46,159,83,14),USE(?STRING1:3), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AmountTip'),AT(46,176,83,14),USE(?STRING1:4), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(133,176,93,12),USE(?AMOUNTTIP)
                                TEXT,AT(133,193,93,12),USE(?AMOUNTFEE)
                                STRING('AmountFee'),AT(46,193,83,14),USE(?STRING1:5), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('CashBack'),AT(46,210,83,14),USE(?STRING1:6),FONT('Micros' & |
                                    'oft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(133,210,93,12),USE(?CASHBACK)
                                TEXT,AT(133,228,93,12),USE(?ACHFORMAT)
                                STRING('ACHFormat'),AT(46,228,83,14),USE(?STRING1:7), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('SMID'),AT(46,246,83,14),USE(?STRING1:8),FONT('Microsoft ' & |
                                    'Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(133,245,93,12),USE(?SMID)
                                STRING('TransactionReference'),AT(299,228,105,14),USE(?STRING1:9), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(421,228,93,12),USE(?TRANSACTIONREF)
                                TEXT,AT(421,210,93,12),USE(?APPROVALNUMBER)
                                STRING('Approval Number'),AT(299,210,83,14),USE(?STRING1:10), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Level2Tax'),AT(299,193,83,14),USE(?STRING1:11), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(421,193,93,12),USE(?LEVEL2TAX)
                                TEXT,AT(421,176,93,12),USE(?LEVEL2ORDERNUMBER)
                                STRING('Level2OrderNumber'),AT(299,176,105,14),USE(?STRING1:12), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Level2CustomerCode'),AT(299,159,105,14),USE(?STRING1:13), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(421,159,93,12),USE(?LEVEL2CUSTOMERCODE)
                                TEXT,AT(421,142,93,12),USE(?BILLINGZIP)
                                STRING('BillingZip'),AT(299,142,61,14),USE(?STRING1:14), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('BillingStreetAddress'),AT(299,124,105,14),USE(?STRING1:15), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(421,124,93,12),USE(?BILLINGSTREETADDRESS)
                            END
                            TAB('Result Fields'),USE(?TAB2)
                            END
                            TAB('Setup String'),USE(?TAB3)
                                TEXT,AT(41,118,497,175),USE(SetupStringBuffer,, ?TEXT1),SCROLL,VSCROLL, |
                                    FONT('Consolas',8),READONLY
                            END
                        END
                        GROUP,AT(21,12,530,63),USE(?GROUP1),BOXED
                            COMBO(@s20),AT(476,22,63),USE(selectedCommand,, ?COMBO1),DROP(3), |
                                FROM('CreditSale|VOID|Setup')
                            BUTTON('&Process'),AT(497,55,43,14),USE(?OkButton),DEFAULT,LEFT
                        END
                        BUTTON('&Close'),AT(569,314,36,14),USE(?CancelButton),LEFT
                    END

    CODE
        
 OPEN(MyWindow)
 ACCEPT
    CASE FIELD()
    OF 0
       CASE EVENT()
        OF EVENT:OpenWindow
            !GetSetupString(DestName)
            SetupString = GetSetupString('setup.txt')
       END
    OF ?OkButton
       CASE EVENT()
        OF EVENT:Accepted
            
                
            
            ParseCommand(selectedCommand)
            
       END
    OF ?CancelButton
       CASE EVENT()
       OF EVENT:Accepted
          POST(EVENT:CloseWindow)
        END
    OF ?COMBO1
        CASE EVENT()
        OF EVENT:ACCEPTED
            
        END
        
    END
        
    END
    
        
        
ParseCommand         PROCEDURE(STRING eiCommand)
  CODE
        !MESSAGE(eiCommand)
         CASE eiCommand
            OF 'VOID'
                MESSAGE(eiCommand)
            OF 'CreditSale'
                MESSAGE(eiCommand)
            OF 'Setup'
               !MESSAGE(SetupString)
                !SetupStringBuffer = 'Setup("' & SetupString & ' ")'
                !DISPLAY(?TEXT1)
                
                !responseOut = ?OLE1{'LoadSetup("' & SetupString & '")'}
                SetupString = ?OLE1{'Setup('& SetupString &')'}
                !responseOut = SetupString
                !MESSAGE(responseOut)
                
                !SetupStringBuffer =  'Setup("' & SetupString & ' ")'
                !MESSAGE(SetupStringBuffer)
               
                !MESSAGE(responseOut)
                SaveSetupString('setup.txt', SetupString)
                
                
                
            END
        
SaveSetupString     FUNCTION(STRING fileLocation, string newSetupString)
    CODE
        DestName = fileLocation
            !CREATE(DestFile)
        !OPEN(DestFile)
        DELETE(DestFile)
        CREATE(DestFile)
        OPEN(DestFile)
        
        DestFile.Line = newSetupString
        ADD(DestFile)
        CLOSE(DestFile)
        GetSetupString(fileLocation)
        
        
        
GetSetupString      FUNCTION(STRING fileLocation)
mySetupString CSTRING(64000)

    CODE
        DestName = fileLocation
            !CREATE(DestFile)
            OPEN(DestFile)
        SET(DestFile)
        
        
            
            Loop 
                Next(DestFile) 
                If ErrorCode() 
                    !Message( ErrorCode() & ' ' & Error() )
                        Break  
                End 
                mySetupString = Clip(DestFile.Record) 
                !Message(MyStringVar) 
            End 
        Close(DestFile) 
        SetupStringBuffer = mySetupString
        DISPLAY(?TEXT1)
        SetupString = SetupStringBuffer
        RETURN mySetupString
        
        


        
        
        
        
        
 