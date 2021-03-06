
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
ParseTransactionResponse        PROCEDURE
PopulateTransactionRequest      PROCEDURE
Sample                  PROCEDURE



                    END




INCLUDE('equates.clw'),ONCE 


selectedCommand       CSTRING(512)
responseOut         CSTRING(64000)
SetupString         CSTRING(64000)
SetupStringBuffer   CSTRING(64000)
ResponseBuffer      CSTRING(64000)


!Trans Fields
AmountTotalBuffer   CSTRING(150)
CashierBuffer       CSTRING(150)
UniqueTransRefBuffer        CSTRING(150)
AmountTipBuffer     CSTRING(150)
AmountFeeBuffer     CSTRING(150)
CashBackBuffer      CSTRING(150)
AchFormatBuffer     CSTRING(150)
SMIDBuffer          CSTRING(150)
TransactionRefBuffer        CSTRING(150)
ApprovalNumberBuffer        CSTRING(150)
Level2TaxBuffer     CSTRING(150)
Level2OrderNumberBuffer     CSTRING(150)
Level2CustomerCodeBuffer    CSTRING(150)
BillingZipBuffer    CSTRING(150)
BillingStreetAddressBuffer CSTRING(150)

!Result Fields
TransactionTypeBuffer       CSTRING(150)
AmountProcessedBuffer       CSTRING(150)
AmountBalanceBuffer CSTRING(150)
CvvResponseTextBuffer       CSTRING(150)
CvvResponseCodeBuffer       CSTRING(150)
AvsResponseTextBuffer       CSTRING(150)
AvsResponseCodeBuffer       CSTRING(150)
AccountCardTypeBuffer       CSTRING(150)
AccountExpiryDateBuffer     CSTRING(150)
AccountEntryMethodBuffer    CSTRING(150)
MaskedAccountBuffer CSTRING(150)
UniqueTransIdBuffer CSTRING(150)
ResultStatusBuffer  CSTRING(64000)
RecFieldBuffer      CSTRING(64000)


!setup.txt file props
DestName  STRING(FILE:MaxFilePath)
LineSize    EQUATE(64000)
FileIndent  EQUATE(20)


DestFile            FILE,DRIVER('ASCII'),CREATE,NAME(DestName)


Record                  RECORD
Line                        STRING(LineSize)
                        END
                    END






MyWindow            WINDOW('Clarion POS'),AT(,,570,299),CENTER,GRAY,AUTO,SYSTEM, |
                        FONT('Microsoft Sans Serif',10,,FONT:regular)
                        OLE,AT(3,2,24,7),USE(?OLE1),HIDE,COMPATIBILITY(021H),CREATE('cipwin32.Ea' & |
                            'syIntegrator')
                        END
                        SHEET,AT(21,50,532,217),USE(?SHEET1)
                            TAB('Trans Fields'),USE(?TAB1)
                                TEXT,AT(134,94,95,11),USE(AmountTotalBuffer,, ?AMOUNTTOTAL)
                                STRING('AmountTotal'),AT(68,93,60,12),USE(?STRING1),FONT('Micros' & |
                                    'oft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Cashier'),AT(68,108,60,12),USE(?STRING1:2),FONT('Microso' & |
                                    'ft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(134,108,95,11),USE(CashierBuffer,, ?CASHIER)
                                TEXT,AT(134,124,95,11),USE(UniqueTransRefBuffer,, ?UNIQUETRANSREF)
                                STRING('UniqueTransRef'),AT(68,123,60,12),USE(?STRING1:3), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AmountTip'),AT(68,138,44,12),USE(?STRING1:4), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(134,138,95,11),USE(AmountTipBuffer,, ?AMOUNTTIP)
                                TEXT,AT(134,154,95,11),USE(AmountFeeBuffer,, ?AMOUNTFEE)
                                STRING('AmountFee'),AT(68,153,48,12),USE(?STRING1:5), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('CashBack'),AT(68,168,70,12),USE(?STRING1:6),FONT('Micros' & |
                                    'oft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(134,168,95,11),USE(CashBackBuffer,, ?CASHBACK)
                                TEXT,AT(134,184,95,11),USE(AchFormatBuffer,, ?ACHFORMAT)
                                STRING('ACHFormat'),AT(68,183,48,12),USE(?STRING1:7), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('SMID'),AT(68,198,60,12),USE(?STRING1:8),FONT('Microsoft ' & |
                                    'Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(134,198,95,11),USE(SMIDBuffer,, ?SMID)
                                STRING('TransactionReference'),AT(300,183,82,12),USE(?STRING1:9), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(382,184,95,11),USE(TransactionRefBuffer,, ?TRANSACTIONREF)
                                TEXT,AT(382,168,95,11),USE(ApprovalNumberBuffer,, ?APPROVALNUMBER)
                                STRING('Approval Number'),AT(300,168,68,12),USE(?STRING1:10), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Level2Tax'),AT(300,153,68,12),USE(?STRING1:11), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(382,154,95,11),USE(Level2TaxBuffer,, ?LEVEL2TAX)
                                TEXT,AT(382,138,95,11),USE(Level2OrderNumberBuffer,, |
                                    ?LEVEL2ORDERNUMBER)
                                STRING('Level2OrderNumber'),AT(300,138,79,12),USE(?STRING1:12), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Level2CustomerCode'),AT(300,123,79,12),USE(?STRING1:13), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(382,124,95,11),USE(Level2CustomerCodeBuffer,, |
                                    ?LEVEL2CUSTOMERCODE)
                                TEXT,AT(382,108,95,11),USE(BillingZipBuffer,, ?BILLINGZIP)
                                STRING('BillingZip'),AT(300,108,56,12),USE(?STRING1:14), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('BillingStreetAddress'),AT(300,93,80,12),USE(?STRING1:15), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(382,94,95,11),USE(BillingStreetAddressBuffer,, |
                                    ?BILLINGSTREETADDRESS)
                            END
                            TAB('Result Fields'),USE(?TAB2)
                                TEXT,AT(102,222,93,12),USE(AmountBalanceBuffer,, ?AmountBalance)
                                STRING('AmountBalance'),AT(27,222,71,14),USE(?STRING1:16), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('CvvResponseText'),AT(27,204,83,14),USE(?STRING1:17), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(102,204,93,12),USE(CvvResponseTextBuffer,, ?CvvResponseText)
                                TEXT,AT(102,186,93,12),USE(CvvResponseCodeBuffer,, ?CvvResponseCode)
                                STRING('CvvResponseCode'),AT(27,186,71,14),USE(?STRING1:18), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AvsResponseText'),AT(27,170,83,14),USE(?STRING1:19), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(102,170,93,12),USE(AvsResponseTextBuffer,, ?AvsResponseText)
                                TEXT,AT(102,152,93,12),USE(AvsResponseCodeBuffer,, ?AvsResponseCode)
                                STRING('AvsResponseCode'),AT(27,152,71,14),USE(?STRING1:20), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AmountProcessed'),AT(27,134,83,14),USE(?STRING1:21), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(102,134,93,12),USE(AmountProcessedBuffer,, ?AmountProcessed)
                                TEXT,AT(102,118,93,12),USE(TransactionTypeBuffer,, ?TransactionType)
                                STRING('TransactionType'),AT(27,118,61,14),USE(?STRING1:22), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('ResultStatus'),AT(27,100,46,14),USE(?STRING1:23), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(102,100,93,12),USE(ResultStatusBuffer,, ?RESULTSTATUS)
                                TEXT,AT(291,100,93,12),USE(AccountCardTypeBuffer,, ?AccountCardType)
                                STRING('AccountCardType'),AT(214,101,46,14),USE(?STRING1:24), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AccountExpiryDate'),AT(214,119,73,14),USE(?STRING1:25), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(291,118,93,12),USE(AccountExpiryDateBuffer,, |
                                    ?AccountExpiryDate)
                                TEXT,AT(291,134,93,12),USE(AccountEntryMethodBuffer,, |
                                    ?AccountEntryMethod)
                                STRING('AccountEntryMethod'),AT(214,135,75,14),USE(?STRING1:26), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('MaskedAccount'),AT(214,153,83,14),USE(?STRING1:27), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(291,152,93,12),USE(MaskedAccountBuffer,, ?MaskedAccount)
                                TEXT,AT(291,170,93,12),USE(UniqueTransIdBuffer,, ?UniqueTransId)
                                STRING('UniqueTransId'),AT(214,171,64,14),USE(?STRING1:28), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('CvvResponseCode'),AT(214,187,83,14),USE(?STRING1:29), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(291,186,93,12),USE(CvvResponseCodeBuffer,, ?CvvResponseCode:2)
                                TEXT,AT(291,204,93,12),USE(CvvResponseTextBuffer,, ?CvvResponseText:2)
                                STRING('CvvResponseText'),AT(214,205,73,14),USE(?STRING1:30), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AmountBalance'),AT(214,223,83,14),USE(?STRING1:31), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(291,222,93,12),USE(AmountBalanceBuffer,, ?AmountBalance:2)
                                TEXT,AT(395,70,151,184),USE(RecFieldBuffer,, ?RecField),SCROLL,VSCROLL, |
                                    RTF(TEXT:FIELD)
                            END
                            TAB('Setup String'),USE(?TAB3)
                                TEXT,AT(35,79,497,175),USE(SetupStringBuffer,, ?TEXT1),SCROLL,VSCROLL, |
                                    FONT('Consolas',8),READONLY
                            END
                        END
                        GROUP,AT(21,12,530,26),USE(?GROUP1),BOXED
                            COMBO(@s20),AT(419,20,77),USE(selectedCommand,, ?COMBO1),LEFT,DROP(5), |
                                FROM('CreditSale|CreditSaveCard|CreditReturn|CreditVoid|Setup')
                            BUTTON('&Process'),AT(500,19,43,14),USE(?OkButton),DEFAULT,LEFT
                        END
                        BUTTON('&Close'),AT(517,278,36,14),USE(?CancelButton),LEFT
                    END

    CODE
        
        AmountTotalBuffer = '1.01'
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
        ?OLE1{'LoadSetup('& SetupString &')'}
        ?OLE1{'Clear'} 
        PopulateTransactionRequest
        

        CASE eiCommand
            OF 'CreditReturn'
            
                MESSAGE(eiCommand)
            OF 'CreditSaveCard'            
                result# = ?OLE1{'CreditSaveCard()'}                                       
            OF 'CreditVoid'
                MESSAGE(eiCommand)
            OF 'CreditSale'
               
                result# = ?OLE1{'CreditSale()'}               

                
            OF 'Setup'
               
                SetupString = ?OLE1{'Setup('& SetupString &')'}
               
                SaveSetupString('setup.txt', SetupString)
                
                
                
        END
        ParseTransactionResponse
        

            
ParseTransactionResponse    PROCEDURE
    CODE
        ResultStatusBuffer = ?OLE1{'ResultsFields.ResultMessage'}
        TransactionTypeBuffer = ?OLE1{'ResultsFields.TransactionType'}        
        AmountProcessedBuffer = ?OLE1{'ResultsFields.AmountProcessed'}
        AmountBalanceBuffer = ?OLE1{'ResultsFields.AmountBalance'}             
        CvvResponseTextBuffer       = ?OLE1{'ResultsFields.CvvResponseText'}           
        CvvResponseCodeBuffer       = ?OLE1{'ResultsFields.CvvResponseCode'}        
        AvsResponseTextBuffer      = ?OLE1{'ResultsFields.AvsResponseText'}
        AvsResponseCodeBuffer       = ?OLE1{'ResultsFields.AvsResponseCode'}        
        AccountCardTypeBuffer        = ?OLE1{'ResultsFields.AccountCardType'}
        AccountExpiryDateBuffer      = ?OLE1{'ResultsFields.AccountExpiryDate'}        
        AccountEntryMethodBuffer     = ?OLE1{'ResultsFields.AccountEntryMethod'}        
        MaskedAccountBuffer  = ?OLE1{'ResultsFields.MaskedAccount'}        
        UniqueTransIdBuffer  = ?OLE1{'ResultsFields.UniqueTransId'}
        RecFieldBuffer  = ?OLE1{'ResultsFields.Receipt'}
        
        !Display the buffer
        DISPLAY(?RESULTSTATUS)        
        DISPLAY(?TransactionType)        
        DISPLAY(?AmountProcessed)
        DISPLAY(?AmountBalance)
        DISPLAY(?CvvResponseText)
        DISPLAY(?CvvResponseCode)
        DISPLAY(?AvsResponseText)
        DISPLAY(?AvsResponseCode)
        DISPLAY(?AccountCardType)
        DISPLAY(?AccountExpiryDate)
        DISPLAY(?AccountEntryMethod)
        DISPLAY(?MaskedAccount)
        DISPLAY(?UniqueTransId)
        DISPLAY(?RecField)
        
        
        
PopulateTransactionRequest  PROCEDURE
    CODE
        ?OLE1{'TransFields.AmountTotal'} = AmountTotalBuffer   
        ?OLE1{'TransFields.Cashier'} = CashierBuffer             
        ?OLE1{'TransFields.UniqueTransRef'} = UniqueTransRefBuffer  
        
        ?OLE1{'TransFields.AmountTip'} = AmountTipBuffer   
        
        ?OLE1{'TransFields.AMountFee'} = AmountFeeBuffer    
        
        ?OLE1{'TransFields.CashBack'} = CashBackBuffer      
        
        ?OLE1{'TransFields.ACHFormat'} = AchFormatBuffer     
        
        ?OLE1{'TransFields.SMID'} = SMIDBuffer        
        
        ?OLE1{'TransFields.TransactionReference'} = TransactionRefBuffer       
        
        ?OLE1{'TransFields.ApprovalNumber'} = ApprovalNumberBuffer       
        
        ?OLE1{'TransFields.Level2Tax'} = Level2TaxBuffer     
        
        ?OLE1{'TransFields.Level2OrderNumber'} = Level2OrderNumberBuffer     
        
        ?OLE1{'TransFields.Level2CustomerCode'} = Level2CustomerCodeBuffer    
        
        ?OLE1{'TransFields.BillingZip'} = BillingZipBuffer    
        
        ?OLE1{'TransFields.BillingStreetAddress'} = BillingStreetAddressBuffer 
        
        
Sample              PROCEDURE
    CODE
        ?OLE1{'LoadSetup('& SetupString &')'}
        ?OLE1{'TransFields.AmountTotal'} = 1.01 
        ?OLE1{'TransFields.Cashier'} = 'Glenn' 
        result# = ?OLE1{'CreditSale()'}             
        ResultStatusBuffer = ?OLE1{'ResultsFields.ResultMessage'}
        

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
        
        


        
        
        
        
        
 