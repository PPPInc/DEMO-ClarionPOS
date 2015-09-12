
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
PopulateTransactionRequest        PROCEDURE

                    


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
ResultStatusBuffer      CSTRING(64000)





DestName  STRING(FILE:MaxFilePath)

 
LineSize    EQUATE(64000)

FileIndent  EQUATE(20)


DestFile  FILE,DRIVER('ASCII'),CREATE,NAME(DestName)

Record     RECORD

Line        STRING(LineSize)

            END

            END



MyWindow            WINDOW('Clarion POS'),AT(,,570,299),CENTER,GRAY,AUTO,SYSTEM, |
                        FONT('Microsoft Sans Serif',10,,FONT:regular)
                        OLE,AT(3,2,24,7),USE(?OLE1),HIDE,COMPATIBILITY(021H),CREATE('cipwin32.Ea' & |
                            'syIntegrator')
                        END
                        SHEET,AT(21,50,532,217),USE(?SHEET1)
                            TAB('Trans Fields'),USE(?TAB1)
                                TEXT,AT(140,108,93,12),USE(AmountTotalBuffer,, ?AMOUNTTOTAL)
                                STRING('AmountTotal'),AT(52,108,,14),USE(?STRING1),FONT('Microso' & |
                                    'ft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Cashier'),AT(52,126,61,14),USE(?STRING1:2),FONT('Microso' & |
                                    'ft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(140,126,93,12),USE(CashierBuffer,, ?CASHIER)
                                TEXT,AT(140,142,93,12),USE(UniqueTransRefBuffer,, ?UNIQUETRANSREF)
                                STRING('UniqueTransRef'),AT(52,142,83,14),USE(?STRING1:3), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AmountTip'),AT(52,160,83,14),USE(?STRING1:4), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(140,160,93,12),USE(AmountTipBuffer,, ?AMOUNTTIP)
                                TEXT,AT(140,178,93,12),USE(AmountFeeBuffer,, ?AMOUNTFEE)
                                STRING('AmountFee'),AT(52,178,83,14),USE(?STRING1:5), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('CashBack'),AT(52,194,83,14),USE(?STRING1:6),FONT('Micros' & |
                                    'oft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(140,194,93,12),USE(CashBackBuffer,, ?CASHBACK)
                                TEXT,AT(140,212,93,12),USE(AchFormatBuffer,, ?ACHFORMAT)
                                STRING('ACHFormat'),AT(52,212,83,14),USE(?STRING1:7), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('SMID'),AT(52,230,83,14),USE(?STRING1:8),FONT('Microsoft ' & |
                                    'Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(140,230,93,12),USE(SMIDBuffer,, ?SMID)
                                STRING('TransactionReference'),AT(306,212,105,14),USE(?STRING1:9), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(428,212,93,12),USE(TransactionRefBuffer,, ?TRANSACTIONREF)
                                TEXT,AT(428,194,93,12),USE(ApprovalNumberBuffer,, ?APPROVALNUMBER)
                                STRING('Approval Number'),AT(306,194,83,14),USE(?STRING1:10), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Level2Tax'),AT(306,178,83,14),USE(?STRING1:11), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(428,178,93,12),USE(Level2TaxBuffer,, ?LEVEL2TAX)
                                TEXT,AT(428,160,93,12),USE(Level2OrderNumberBuffer,, |
                                    ?LEVEL2ORDERNUMBER)
                                STRING('Level2OrderNumber'),AT(306,160,105,14),USE(?STRING1:12), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('Level2CustomerCode'),AT(306,142,105,14),USE(?STRING1:13), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(428,142,93,12),USE(Level2CustomerCodeBuffer,, |
                                    ?LEVEL2CUSTOMERCODE)
                                TEXT,AT(428,126,93,12),USE(BillingZipBuffer,, ?BILLINGZIP)
                                STRING('BillingZip'),AT(306,126,61,14),USE(?STRING1:14), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('BillingStreetAddress'),AT(306,108,105,14),USE(?STRING1:15), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(428,108,93,12),USE(BillingStreetAddressBuffer,, |
                                    ?BILLINGSTREETADDRESS)
                            END
                            TAB('Result Fields'),USE(?TAB2)
                                TEXT,AT(132,250,93,12),USE(AmountBalanceBuffer,, ?AmountBalance)
                                STRING('AmountBalance'),AT(44,250,83,14),USE(?STRING1:16), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('CvvResponseText'),AT(44,232,83,14),USE(?STRING1:17), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(132,232,93,12),USE(CvvResponseTextBuffer,, ?CvvResponseText)
                                TEXT,AT(132,214,93,12),USE(CvvResponseCodeBuffer,, ?CvvResponseCode)
                                STRING('CvvResponseCode'),AT(44,214,83,14),USE(?STRING1:18), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AvsResponseText'),AT(44,198,83,14),USE(?STRING1:19), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(132,198,93,12),USE(AvsResponseTextBuffer,, ?AvsResponseText)
                                TEXT,AT(132,180,93,12),USE(AvsResponseCodeBuffer,, ?AvsResponseCode)
                                STRING('AvsResponseCode'),AT(44,180,83,14),USE(?STRING1:20), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AmountProcessed'),AT(44,162,83,14),USE(?STRING1:21), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(132,162,93,12),USE(AmountProcessedBuffer,, ?AmountProcessed)
                                TEXT,AT(132,146,93,12),USE(TransactionTypeBuffer,, ?TransactionType)
                                STRING('TransactionType'),AT(44,146,61,14),USE(?STRING1:22), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('ResultStatus'),AT(44,128,46,14),USE(?STRING1:23), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(132,128,93,12),USE(ResultStatusBuffer,, ?RESULTSTATUS)
                                TEXT,AT(362,130,93,12),USE(AccountCardTypeBuffer,, ?AccountCardType)
                                STRING('AccountCardType'),AT(274,130,46,14),USE(?STRING1:24), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AccountExpiryDate'),AT(274,148,73,14),USE(?STRING1:25), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(362,148,93,12),USE(AccountExpiryDateBuffer,, |
                                    ?AccountExpiryDate)
                                TEXT,AT(362,164,93,12),USE(AccountEntryMethodBuffer,, |
                                    ?AccountEntryMethod)
                                STRING('AccountEntryMethod'),AT(274,164,83,14),USE(?STRING1:26), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('MaskedAccount'),AT(274,182,83,14),USE(?STRING1:27), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(362,182,93,12),USE(MaskedAccountBuffer,, ?MaskedAccount)
                                TEXT,AT(362,200,93,12),USE(UniqueTransIdBuffer,, ?UniqueTransId)
                                STRING('UniqueTransId'),AT(274,200,83,14),USE(?STRING1:28), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('CvvResponseCode'),AT(274,216,83,14),USE(?STRING1:29), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(362,216,93,12),USE(CvvResponseCodeBuffer,, ?CvvResponseCode:2)
                                TEXT,AT(362,234,93,12),USE(CvvResponseTextBuffer,, ?CvvResponseText:2)
                                STRING('CvvResponseText'),AT(274,234,83,14),USE(?STRING1:30), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                STRING('AmountBalance'),AT(274,252,83,14),USE(?STRING1:31), |
                                    FONT('Microsoft Sans Serif',12),COLOR(COLOR:White)
                                TEXT,AT(362,252,93,12),USE(AmountBalanceBuffer,, ?AmountBalance:2)
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
        !MESSAGE(eiCommand)
        ?OLE1{'LoadSetup('& SetupString &')'}
        CASE eiCommand
            OF 'CreditReturn'
            
                MESSAGE(eiCommand)
            OF 'CreditSaveCard'
            
                MESSAGE(eiCommand)
            
            OF 'CreditVoid'
                MESSAGE(eiCommand)
            OF 'CreditSale'
                !MESSAGE(eiCommand)
                
                !?OLE1{'TransFields.AmountTotal'} = AmountTotalBuffer
                PopulateTransactionRequest
                x# = ?OLE1{'CreditSale()'}
               
                ParseTransactionResponse

                
            OF 'Setup'
               !MESSAGE(SetupString)
                !SetupStringBuffer = 'Setup("' & SetupString & ' ")'
                !DISPLAY(?TEXT1)
                
                !responseOut = ?OLE1{'LoadSetup("' & SetupString & '")'}
                 !SetupString = ?OLE1{'Setup(" ")'}
                SetupString = ?OLE1{'Setup('& SetupString &')'}
                !responseOut = SetupString
                !MESSAGE(responseOut)
                
                !SetupStringBuffer =  'Setup("' & SetupString & ' ")'
                !MESSAGE(SetupStringBuffer)
               
                !MESSAGE(responseOut)
                SaveSetupString('setup.txt', SetupString)
                
                
                
            END
            
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
        
        


        
        
        
        
        
 