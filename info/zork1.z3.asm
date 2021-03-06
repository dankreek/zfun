Resident data ends at 4e37, program starts at 4f04, file ends at 14b8c

Starting analysis pass at address 4e37

End of analysis pass, low address = 4e38, high address = 10b04

[Start of code at 4e38]

Routine 4e38, 1 local (0000)

 4e3b:  b2 ...                  PRINT           "a "
 4e3e:  aa 01                   PRINT_OBJ       L00
 4e40:  b0                      RTRUE           

Routine 4e42, 1 local (0000)

 4e45:  a0 4c cb                JZ              G3c [TRUE] 4e51
 4e48:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 4e4c:  63 01 00 c1             JG              L00,(SP)+ [TRUE] RTRUE
 4e50:  b1                      RFALSE          
 4e51:  e7 3f 01 2c 00          RANDOM          #012c -> -(SP)
 4e56:  63 01 00 c1             JG              L00,(SP)+ [TRUE] RTRUE
 4e5a:  b1                      RFALSE          

Routine 4e5c, 1 local (0000)

 4e5f:  4f 01 00 00             LOADW           L00,#00 -> -(SP)
 4e63:  e7 bf 00 00             RANDOM          (SP)+ -> -(SP)
 4e67:  6f 01 00 00             LOADW           L00,(SP)+ -> -(SP)
 4e6b:  b8                      RET_POPPED      

Routine 4e6c, 6 locals (0000, 0000, 0000, 0000, 0000, 0000)

 4e79:  4f 01 00 02             LOADW           L00,#00 -> L01
 4e7d:  4f 01 01 03             LOADW           L00,#01 -> L02
 4e81:  96 02                   DEC             L01
 4e83:  54 01 02 01             ADD             L00,#02 -> L00
 4e87:  56 03 02 00             MUL             L02,#02 -> -(SP)
 4e8b:  74 01 00 06             ADD             L00,(SP)+ -> L05
 4e8f:  75 02 03 00             SUB             L01,L02 -> -(SP)
 4e93:  e7 bf 00 04             RANDOM          (SP)+ -> L03
 4e97:  6f 06 04 05             LOADW           L05,L03 -> L04
 4e9b:  4f 06 01 00             LOADW           L05,#01 -> -(SP)
 4e9f:  e1 ab 06 04 00          STOREW          L05,L03,(SP)+
 4ea4:  e1 9b 06 01 05          STOREW          L05,#01,L04
 4ea9:  95 03                   INC             L02
 4eab:  61 03 02 45             JE              L02,L01 [FALSE] 4eb2
 4eaf:  0d 03 00                STORE           L02,#00
 4eb2:  e1 9b 01 00 03          STOREW          L00,#00,L02
 4eb7:  ab 05                   RET             L04

Routine 4eba, 0 locals ()

 4ebb:  41 88 2b 40             JE              G78,#2b [FALSE] RFALSE
 4ebf:  e0 1f 48 5d a3 00       CALL            90ba (#a3) -> -(SP)
 4ec5:  b1                      RFALSE          

Routine 4ec6, 0 locals ()

 4ec7:  a0 3e d9                JZ              G2e [TRUE] 4ee1
 4eca:  0a ae 0b 44             TEST_ATTR       "grating",#0b [FALSE] 4ed0
 4ece:  9b 39                   RET             #39
 4ed0:  b2 ...                  PRINT           "The grating is closed!"
 4ed9:  bb                      NEW_LINE        
 4eda:  e0 1f 4a 98 ae 00       CALL            9530 (#ae) -> -(SP)
 4ee0:  b1                      RFALSE          
 4ee1:  b2 ...                  PRINT           "You can't go that way."
 4eec:  bb                      NEW_LINE        
 4eed:  b1                      RFALSE          

Routine 4eee, 1 local (0000)

 4ef1:  41 01 01 40             JE              L00,#01 [FALSE] RFALSE
 4ef5:  41 88 45 40             JE              G78,#45 [FALSE] RFALSE
 4ef9:  a0 86 40                JZ              G76 [FALSE] RFALSE
 4efc:  e0 0f 83 33 98 3b 00    CALL            10666 (S148) -> -(SP)
 4f03:  b0                      RTRUE           

Main routine 4f04, 0 locals ()

 4f05:  e0 03 2a 39 80 10 ff ff 00 
                               CALL            5472 (#8010,#ffff) -> -(SP)
 4f0e:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 4f13:  e0 03 2a 39 80 7c ff ff 00 
                               CALL            5472 (#807c,#ffff) -> -(SP)
 4f1c:  e0 03 2a 39 80 f0 ff ff 00 
                               CALL            5472 (#80f0,#ffff) -> -(SP)
 4f25:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 4f2a:  e0 07 2a 39 6f 6a 28 00 CALL            5472 (#6f6a,#28) -> -(SP)
 4f32:  e0 07 2a 39 6f 55 c8 00 CALL            5472 (#6f55,#c8) -> -(SP)
 4f3a:  e3 57 9c 06 04          PUT_PROP        "magic boat",#06,#04
 4f3f:  54 20 02 00             ADD             G10,#02 -> -(SP)
 4f43:  e1 9b 1a 01 00          STOREW          G0a,#01,(SP)+
 4f48:  54 20 04 00             ADD             G10,#04 -> -(SP)
 4f4c:  e1 9b 1a 02 00          STOREW          G0a,#02,(SP)+
 4f51:  54 1e 02 00             ADD             G0e,#02 -> -(SP)
 4f55:  e1 9b 19 02 00          STOREW          G09,#02,(SP)+
 4f5a:  54 1e 04 00             ADD             G0e,#04 -> -(SP)
 4f5e:  e1 9b 19 03 00          STOREW          G09,#03,(SP)+
 4f63:  54 1d 02 00             ADD             G0d,#02 -> -(SP)
 4f67:  e1 9b 18 01 00          STOREW          G08,#01,(SP)+
 4f6c:  54 1c 02 00             ADD             G0c,#02 -> -(SP)
 4f70:  e1 9b 18 03 00          STOREW          G08,#03,(SP)+
 4f75:  0d 10 b4                STORE           G00,#b4
 4f78:  e0 1f 4a 98 a0 00       CALL            9530 (#a0) -> -(SP)
 4f7e:  4a 10 03 c8             TEST_ATTR       G00,#03 [TRUE] 4f88
 4f82:  e0 3f 37 70 00          CALL            6ee0 -> -(SP)
 4f87:  bb                      NEW_LINE        
 4f88:  0d 52 01                STORE           G42,#01
 4f8b:  0d 7f 04                STORE           G6f,#04
 4f8e:  2d 90 7f                STORE           G80,G6f
 4f91:  6e 7f 10                INSERT_OBJ      G6f,G00
 4f94:  e0 3f 3f 02 00          CALL            7e04 -> -(SP)
 4f99:  e0 3f 2a 95 00          CALL            552a -> -(SP)
 4f9e:  8c ff 66                JUMP            4f05

Routine 4fa2, 3 locals (0000, 0001, 0000)

 4fa9:  41 86 0b 59             JE              G76,#0b [FALSE] 4fc4
 4fad:  41 87 0b 55             JE              G77,#0b [FALSE] 4fc4
 4fb1:  b3 ...                  PRINT_RET       "Those things aren't here!"
 4fc4:  41 86 0b 48             JE              G76,#0b [FALSE] 4fce
 4fc8:  2d 01 66                STORE           L00,G56
 4fcb:  8c 00 08                JUMP            4fd4
 4fce:  2d 01 65                STORE           L00,G55
 4fd1:  0d 02 00                STORE           L01,#00
 4fd4:  0d 7c 00                STORE           G6c,#00
 4fd7:  0d 70 00                STORE           G60,#00
 4fda:  61 7f 90 56             JE              G6f,G80 [FALSE] 4ff2
 4fde:  b2 ...                  PRINT           "You can't see any"
 4fe7:  e0 2f 28 49 02 00       CALL            5092 (L01) -> -(SP)
 4fed:  b3 ...                  PRINT_RET       " here!"
 4ff2:  b2 ...                  PRINT           "The "
 4ff5:  aa 7f                   PRINT_OBJ       G6f
 4ff7:  b2 ...                  PRINT           " seems confused. "I don't see any"
 500a:  e0 2f 28 49 02 00       CALL            5092 (L01) -> -(SP)
 5010:  b3 ...                  PRINT_RET       " here!""

Routine 5018, 4 locals (0000, 0000, 0000, 0000)

 5021:  e0 2f 34 3e 01 03       CALL            687c (L00) -> L02
 5027:  43 03 01 53             JG              L02,#01 [FALSE] 503c
 502b:  4f 01 01 00             LOADW           L00,#01 -> -(SP)
 502f:  51 00 05 04             GET_PROP        (SP)+,#05 -> L03
 5033:  a0 04 c8                JZ              L03 [TRUE] 503c
 5036:  0d 03 01                STORE           L02,#01
 5039:  2d 5c 04                STORE           G4c,L03
 503c:  21 01 03 4d             JE              #01,L02 [FALSE] 504b
 5040:  a0 02 c6                JZ              L01 [TRUE] 5047
 5043:  2d 86 5c                STORE           G76,G4c
 5046:  b1                      RFALSE          
 5047:  2d 87 5c                STORE           G77,G4c
 504a:  b1                      RFALSE          
 504b:  a0 02 5c                JZ              L01 [FALSE] 5068
 504e:  b2 ...                  PRINT           "You wouldn't find any"
 505d:  e0 2f 28 49 02 00       CALL            5092 (L01) -> -(SP)
 5063:  b3 ...                  PRINT_RET       " there."
 5068:  9b 0b                   RET             #0b

Routine 506a, 1 local (0000)

 506d:  0d 7c 00                STORE           G6c,#00
 5070:  0d 70 00                STORE           G60,#00
 5073:  b2 ...                  PRINT           "You can't see any"
 507c:  61 01 86 4a             JE              L00,G76 [FALSE] 5088
 5080:  e0 3f 36 66 00          CALL            6ccc -> -(SP)
 5085:  8c 00 07                JUMP            508d
 5088:  e0 3f 36 7a 00          CALL            6cf4 -> -(SP)
 508d:  b3 ...                  PRINT_RET       " here."

Routine 5092, 2 locals (0000, 0000)

 5097:  a0 79 d3                JZ              G69 [TRUE] 50ab
 509a:  a0 5a c7                JZ              G4a [TRUE] 50a2
 509d:  b2 ...                  PRINT           " "
 50a0:  a7 59                   PRINT_ADDR      G49
 50a2:  a0 5b c0                JZ              G4b [TRUE] RFALSE
 50a5:  b2 ...                  PRINT           " "
 50a8:  a7 5b                   PRINT_ADDR      G4b
 50aa:  b0                      RTRUE           
 50ab:  a0 01 d3                JZ              L00 [TRUE] 50bf
 50ae:  4f 74 06 02             LOADW           G64,#06 -> L01
 50b2:  4f 74 07 00             LOADW           G64,#07 -> -(SP)
 50b6:  e0 29 31 77 02 00 00 00 CALL            62ee (L01,(SP)+,#00) -> -(SP)
 50be:  b8                      RET_POPPED      
 50bf:  4f 74 08 02             LOADW           G64,#08 -> L01
 50c3:  4f 74 09 00             LOADW           G64,#09 -> -(SP)
 50c7:  e0 29 31 77 02 00 00 00 CALL            62ee (L01,(SP)+,#00) -> -(SP)
 50cf:  b8                      RET_POPPED      

Routine 50d0, 2 locals (0000, 0000)

 50d5:  b1                      RFALSE          

Routine 50d6, 0 locals ()

 50d7:  41 88 22 40             JE              G78,#22 [FALSE] RFALSE
 50db:  b3 ...                  PRINT_RET       "You should say whether you want to go up or down."

Routine 50fa, 0 locals ()

 50fb:  41 88 42 40             JE              G78,#42 [FALSE] RFALSE
 50ff:  95 55                   INC             G45
 5101:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 5106:  58 55 14 00             MOD             G45,#14 -> -(SP)
 510a:  a0 00 59                JZ              (SP)+ [FALSE] 5124
 510d:  b3 ...                  PRINT_RET       "You seem to be repeating yourself."
 5124:  58 55 0a 00             MOD             G45,#0a -> -(SP)
 5128:  a0 00 5d                JZ              (SP)+ [FALSE] 5146
 512b:  b3 ...                  PRINT_RET       "I think that phrase is getting a bit worn out."
 5146:  b3 ...                  PRINT_RET       "Nothing happens here."

Routine 5156, 0 locals ()

 5157:  c1 97 88 32 12 4e       JE              G78,#32,#12 [FALSE] 5169
 515d:  41 87 08 4a             JE              G77,#08 [FALSE] 5169
 5161:  e0 1b 2b be 31 86 00    CALL            577c (#31,G76) -> -(SP)
 5168:  b0                      RTRUE           
 5169:  41 10 7e 48             JE              G00,#7e [FALSE] 5173
 516d:  e0 3f 76 e3 00          CALL            edc6 -> -(SP)
 5172:  b8                      RET_POPPED      
 5173:  41 88 2c 40             JE              G78,#2c [FALSE] RFALSE
 5177:  b3 ...                  PRINT_RET       "The ground is too hard for digging here."

Routine 518a, 0 locals ()

 518b:  41 88 38 00 ab          JE              G78,#38 [FALSE] 5239
 5190:  b3 ...                  PRINT_RET       "The grue is a sinister, lurking presence in the dark places of the earth. Its favorite diet is adventurers, but its insatiable appetite is tempered by its fear of light. No grue has ever been seen by the light of day, and few have survived its fearsome jaws to tell the tale."
 5239:  41 88 3c 00 51          JE              G78,#3c [FALSE] 528d
 523e:  b3 ...                  PRINT_RET       "There is no grue here, but I'm sure there is at least one lurking in the darkness nearby. I wouldn't let my light go out if I were you!"
 528d:  41 88 4d 40             JE              G78,#4d [FALSE] RFALSE
 5291:  b3 ...                  PRINT_RET       "It makes no sound but is always lurking in the darkness nearby."

Routine 52b8, 1 local (0000)

 52bb:  41 88 6f 77             JE              G78,#6f [FALSE] 52f4
 52bf:  0d 7c 00                STORE           G6c,#00
 52c2:  0d 70 00                STORE           G60,#00
 52c5:  b3 ...                  PRINT_RET       "Talking to yourself is said to be a sign of impending mental collapse."
 52f4:  41 88 3f 4e             JE              G78,#3f [FALSE] 5304
 52f8:  41 87 05 4a             JE              G77,#05 [FALSE] 5304
 52fc:  e0 1b 2b be 5d 86 00    CALL            577c (#5d,G76) -> -(SP)
 5303:  b0                      RTRUE           
 5304:  41 88 56 4f             JE              G78,#56 [FALSE] 5315
 5308:  b3 ...                  PRINT_RET       "Only you can do that."
 5315:  41 88 2d 57             JE              G78,#2d [FALSE] 532e
 5319:  b3 ...                  PRINT_RET       "You'll have to do that on your own."
 532e:  41 88 33 59             JE              G78,#33 [FALSE] 5349
 5332:  b3 ...                  PRINT_RET       "Auto-cannibalism is not the answer."
 5349:  c1 97 88 2a 13 62       JE              G78,#2a,#13 [FALSE] 536f
 534f:  a0 87 ce                JZ              G77 [TRUE] 535e
 5352:  4a 87 1d 4a             TEST_ATTR       G77,#1d [FALSE] 535e
 5356:  e0 0f 83 33 9a 39 00    CALL            10666 (S164) -> -(SP)
 535d:  b8                      RET_POPPED      
 535e:  b3 ...                  PRINT_RET       "Suicide is not the answer."
 536f:  41 88 5d 4d             JE              G78,#5d [FALSE] 537e
 5373:  b3 ...                  PRINT_RET       "How romantic!"
 537e:  41 88 38 40             JE              G78,#38 [FALSE] RFALSE
 5382:  93 97 01                GET_PARENT      "mirror" -> L00
 5385:  93 99 00                GET_PARENT      "mirror" -> -(SP)
 5388:  c1 ab 10 01 00 59       JE              G00,L00,(SP)+ [FALSE] 53a5
 538e:  b3 ...                  PRINT_RET       "Your image in the mirror looks tired."
 53a5:  b3 ...                  PRINT_RET       "That's difficult unless your eyes are prehensile."

Routine 53c6, 0 locals ()

 53c7:  c1 97 88 3d 5d 59       JE              G78,#3d,#5d [FALSE] 53e4
 53cd:  b3 ...                  PRINT_RET       "You must specify a direction to go."
 53e4:  41 88 3c 53             JE              G78,#3c [FALSE] 53f9
 53e8:  b3 ...                  PRINT_RET       "I can't help you there...."
 53f9:  41 88 2c 40             JE              G78,#2c [FALSE] RFALSE
 53fd:  b3 ...                  PRINT_RET       "Not a chance."

Routine 5408, 0 locals ()

 5409:  41 88 38 69             JE              G78,#38 [FALSE] 5434
 540d:  b3 ...                  PRINT_RET       "The zorkmid is the unit of currency of the Great Underground Empire."
 5434:  41 88 3c 40             JE              G78,#3c [FALSE] RFALSE
 5438:  b3 ...                  PRINT_RET       "The best way to find zorkmids is to go out and look for them."

Routine 545c, 3 locals (0000, 0000, 0000)

 5463:  e0 27 2a 43 01 01 03    CALL            5486 (L00,#01) -> L02
 546a:  e1 9b 03 01 02          STOREW          L02,#01,L01
 546f:  ab 03                   RET             L02

Routine 5472, 3 locals (0000, 0000, 0000)

 5479:  e0 2f 2a 43 01 03       CALL            5486 (L00) -> L02
 547f:  e1 9b 03 01 02          STOREW          L02,#01,L01
 5484:  ab 03                   RET             L02

Routine 5486, 5 locals (0000, 0000, 0000, 0000, 0000)
;; Start
 5491:  54 94 b4 03             ADD             G84,#b4 -> L02  ;; L02 = $23e9 + $ffb4 = $239d
 5495:  74 94 92 04             ADD             G84,G82 -> L03  ;; L03 = $23e9 + $b4 = $249d
;;
 5499:  61 04 03 58             JE              L03,L02 [FALSE] 54b3
 549d:  55 92 06 92             SUB             G82,#06 -> G82
 54a1:  a0 02 c6                JZ              L01 [TRUE] 54a8
 54a4:  55 93 06 93             SUB             G83,#06 -> G83
;;
 54a8:  74 94 92 05             ADD             G84,G82 -> L04
 54ac:  e1 9b 05 02 01          STOREW          L04,#02,L00
 54b1:  ab 05                   RET             L04
;;
 54b3:  4f 04 02 00             LOADW           L03,#02 -> -(SP)
 54b7:  61 00 01 44             JE              (SP)+,L00 [FALSE] 54bd
 54bb:  ab 04                   RET             L03
;;
 54bd:  54 04 06 04             ADD             L03,#06 -> L03
 54c1:  8c ff d7                JUMP            5499

Routine 54c4, 4 locals (0000, 0000, 0000, 0000)

 54cd:  a0 91 c6                JZ              G81 [TRUE] 54d4
 54d0:  0d 91 00                STORE           G81,#00
 54d3:  b1                      RFALSE          
 54d4:  a0 8f c8                JZ              G7f [TRUE] 54dd
 54d7:  e8 bf 92                PUSH            G82
 54da:  8c 00 05                JUMP            54e0
 54dd:  e8 bf 93                PUSH            G83
 54e0:  74 94 00 01             ADD             G84,(SP)+ -> L00
 54e4:  54 94 b4 02             ADD             G84,#b4 -> L01
 54e8:  61 01 02 4d             JE              L00,L01 [FALSE] 54f7
 54ec:  c5 4f 12 03 e7 45       INC_CHK         G02,#03e7 [FALSE] 54f5
 54f2:  0d 12 00                STORE           G02,#00
 54f5:  ab 04                   RET             L03
 54f7:  4f 01 00 00             LOADW           L00,#00 -> -(SP)
 54fb:  a0 00 e7                JZ              (SP)+ [TRUE] 5523
 54fe:  4f 01 01 03             LOADW           L00,#01 -> L02
 5502:  a0 03 45                JZ              L02 [FALSE] 5508
 5505:  8c 00 1d                JUMP            5523
 5508:  55 03 01 00             SUB             L02,#01 -> -(SP)
 550c:  e1 9b 01 01 00          STOREW          L00,#01,(SP)+
 5511:  43 03 01 d0             JG              L02,#01 [TRUE] 5523
 5515:  4f 01 02 00             LOADW           L00,#02 -> -(SP)
 5519:  e0 bf 00 00             CALL            (SP)+ -> -(SP)
 551d:  a0 00 c5                JZ              (SP)+ [TRUE] 5523
 5520:  0d 04 01                STORE           L03,#01
 5523:  54 01 06 01             ADD             L00,#06 -> L00
 5527:  8c ff c0                JUMP            54e8

Routine 552a, 10 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000)

 553f:  0d 04 00                STORE           L03,#00
 5542:  0d 05 00                STORE           L04,#00
 5545:  0d 08 01                STORE           L07,#01
 5548:  e0 3f 2c 40 8f          CALL            5880 -> G7f
 554d:  a0 8f 81 fc             JZ              G7f [TRUE] 574b
 5551:  6f 65 61 01             LOADW           G55,G51 -> L00
 5555:  6f 66 61 02             LOADW           G56,G51 -> L01
 5559:  a0 02 48                JZ              L01 [FALSE] 5562
 555c:  e8 bf 02                PUSH            L01
 555f:  8c 00 33                JUMP            5593
 5562:  43 02 01 58             JG              L01,#01 [FALSE] 557c
 5566:  2d 06 66                STORE           L05,G56
 5569:  a0 01 48                JZ              L00 [FALSE] 5572
 556c:  0d 05 00                STORE           L04,#00
 556f:  8c 00 06                JUMP            5576
 5572:  4f 65 01 05             LOADW           G55,#01 -> L04
 5576:  e8 bf 02                PUSH            L01
 5579:  8c 00 19                JUMP            5593
 557c:  43 01 01 52             JG              L00,#01 [FALSE] 5590
 5580:  0d 08 00                STORE           L07,#00
 5583:  2d 06 65                STORE           L05,G55
 5586:  4f 66 01 05             LOADW           G56,#01 -> L04
 558a:  e8 bf 01                PUSH            L00
 558d:  8c 00 05                JUMP            5593
 5590:  e8 7f 01                PUSH            #01
 5593:  2d 03 00                STORE           L02,(SP)+
 5596:  a0 05 4a                JZ              L04 [FALSE] 55a1
 5599:  41 01 01 46             JE              L00,#01 [FALSE] 55a1
 559d:  4f 65 01 05             LOADW           G55,#01 -> L04
 55a1:  41 88 89 4c             JE              G78,#89 [FALSE] 55af
 55a5:  e0 2b 2b be 88 86 07    CALL            577c (G78,G76) -> L06
 55ac:  8c 01 6a                JUMP            5717
 55af:  a0 03 00 4f             JZ              L02 [FALSE] 5600
 55b3:  50 83 00 00             LOADB           G73,#00 -> -(SP)
 55b7:  49 00 03 00             AND             (SP)+,#03 -> -(SP)
 55bb:  a0 00 4e                JZ              (SP)+ [FALSE] 55ca
 55be:  e0 2f 2b be 88 07       CALL            577c (G78) -> L06
 55c4:  0d 86 00                STORE           G76,#00
 55c7:  8c 01 4f                JUMP            5717
 55ca:  a0 52 53                JZ              G42 [FALSE] 55de
 55cd:  b2 ...                  PRINT           "It's too dark to see."
 55da:  bb                      NEW_LINE        
 55db:  8c 01 3b                JUMP            5717
 55de:  b2 ...                  PRINT           "It's not clear what you're referring to."
 55f9:  bb                      NEW_LINE        
 55fa:  0d 07 00                STORE           L06,#00
 55fd:  8c 01 19                JUMP            5717
 5600:  0d 8a 00                STORE           G7a,#00
 5603:  0d 8b 00                STORE           G7b,#00
 5606:  43 03 01 45             JG              L02,#01 [FALSE] 560d
 560a:  0d 8b 01                STORE           G7b,#01
 560d:  0d 0a 00                STORE           L09,#00
 5610:  25 04 03 00 5b          INC_CHK         L03,L02 [FALSE] 566e
 5615:  43 8a 00 00 3d          JG              G7a,#00 [FALSE] 5655
 561a:  b2 ...                  PRINT           "The "
 561d:  61 8a 03 c5             JE              G7a,L02 [TRUE] 5624
 5621:  b2 ...                  PRINT           "other "
 5624:  b2 ...                  PRINT           "object"
 5629:  41 8a 01 c5             JE              G7a,#01 [TRUE] 5630
 562d:  b2 ...                  PRINT           "s"
 5630:  b2 ...                  PRINT           " that you mentioned "
 563d:  41 8a 01 c8             JE              G7a,#01 [TRUE] 5647
 5641:  b2 ...                  PRINT           "are"
 5644:  8c 00 05                JUMP            564a
 5647:  b2 ...                  PRINT           "is"
 564a:  b2 ...                  PRINT           "n't here."
 5651:  bb                      NEW_LINE        
 5652:  8c 00 c4                JUMP            5717
 5655:  a0 0a 00 c0             JZ              L09 [FALSE] 5717
 5659:  b2 ...                  PRINT           "There's nothing here you can take."
 566a:  bb                      NEW_LINE        
 566b:  8c 00 ab                JUMP            5717
 566e:  a0 08 c9                JZ              L07 [TRUE] 5678
 5671:  6f 66 04 09             LOADW           G56,L03 -> L08
 5675:  8c 00 06                JUMP            567c
 5678:  6f 65 04 09             LOADW           G55,L03 -> L08
 567c:  a0 08 c8                JZ              L07 [TRUE] 5685
 567f:  e8 bf 09                PUSH            L08
 5682:  8c 00 05                JUMP            5688
 5685:  e8 bf 05                PUSH            L04
 5688:  2d 86 00                STORE           G76,(SP)+
 568b:  a0 08 c8                JZ              L07 [TRUE] 5694
 568e:  e8 bf 05                PUSH            L04
 5691:  8c 00 05                JUMP            5697
 5694:  e8 bf 09                PUSH            L08
 5697:  2d 87 00                STORE           G77,(SP)+
 569a:  43 03 01 d1             JG              L02,#01 [TRUE] 56ad
 569e:  4f 74 06 00             LOADW           G64,#06 -> -(SP)
 56a2:  4f 00 00 00             LOADW           (SP)+,#00 -> -(SP)
 56a6:  c1 8f 00 3b 7c 00 59    JE              (SP)+,"all" [FALSE] 5704
 56ad:  41 09 0b 47             JE              L08,#0b [FALSE] 56b6
 56b1:  95 8a                   INC             G7a
 56b3:  8c ff 5c                JUMP            5610
 56b6:  41 88 5d 5a             JE              G78,#5d [FALSE] 56d2
 56ba:  a0 87 d7                JZ              G77 [TRUE] 56d2
 56bd:  4f 74 06 00             LOADW           G64,#06 -> -(SP)
 56c1:  4f 00 00 00             LOADW           (SP)+,#00 -> -(SP)
 56c5:  c1 8f 00 3b 7c 49       JE              (SP)+,"all" [FALSE] 56d2
 56cb:  66 86 87 c5             JIN             G76,G77 [TRUE] 56d2
 56cf:  8c ff 40                JUMP            5610
 56d2:  41 60 01 62             JE              G50,#01 [FALSE] 56f6
 56d6:  41 88 5d 5e             JE              G78,#5d [FALSE] 56f6
 56da:  a3 09 00                GET_PARENT      L08 -> -(SP)
 56dd:  c1 ab 00 7f 10 ca       JE              (SP)+,G6f,G00 [TRUE] 56eb
 56e3:  a3 09 00                GET_PARENT      L08 -> -(SP)
 56e6:  4a 00 0a 3f 27          TEST_ATTR       (SP)+,#0a [FALSE] 5610
 56eb:  4a 09 11 c9             TEST_ATTR       L08,#11 [TRUE] 56f6
 56ef:  4a 09 0d c5             TEST_ATTR       L08,#0d [TRUE] 56f6
 56f3:  8c ff 1c                JUMP            5610
 56f6:  41 09 0c 47             JE              L08,#0c [FALSE] 56ff
 56fa:  aa 7b                   PRINT_OBJ       G6b
 56fc:  8c 00 04                JUMP            5701
 56ff:  aa 09                   PRINT_OBJ       L08
 5701:  b2 ...                  PRINT           ": "
 5704:  0d 0a 01                STORE           L09,#01
 5707:  e0 2a 2b be 88 86 87 07 CALL            577c (G78,G76,G77) -> L06
 570f:  41 07 02 3e fe          JE              L06,#02 [FALSE] 5610
 5714:  8c 00 02                JUMP            5717
 5717:  41 07 02 ce             JE              L06,#02 [TRUE] 5727
 571b:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 571e:  51 00 11 00             GET_PROP        (SP)+,#11 -> -(SP)
 5722:  e0 9f 00 06 07          CALL            (SP)+ (#06) -> L06
 5727:  c1 95 88 08 89 0f d5    JE              G78,#08,#89,#0f [TRUE] 5741
 572e:  c1 95 88 0c 09 07 45    JE              G78,#0c,#09,#07 [FALSE] 5738
 5735:  8c 00 0b                JUMP            5741
 5738:  2d 8e 88                STORE           G7e,G78
 573b:  2d 8d 86                STORE           G7d,G76
 573e:  2d 8c 87                STORE           G7c,G77
 5741:  41 07 02 4b             JE              L06,#02 [FALSE] 574e
 5745:  0d 7c 00                STORE           G6c,#00
 5748:  8c 00 05                JUMP            574e
 574b:  0d 7c 00                STORE           G6c,#00
 574e:  a0 8f bd ef             JZ              G7f [TRUE] 553f
 5752:  c1 95 88 02 01 6f bd e7 JE              G78,#02,#01,#6f [TRUE] 553f
 575a:  c1 95 88 0c 08 00 bd df JE              G78,#0c,#08,#00 [TRUE] 553f
 5762:  c1 95 88 09 06 05 bd d7 JE              G78,#09,#06,#05 [TRUE] 553f
 576a:  c1 95 88 07 0b 0a 45    JE              G78,#07,#0b,#0a [FALSE] 5774
 5771:  8c fd cd                JUMP            553f
 5774:  e0 3f 2a 62 07          CALL            54c4 -> L06
 5779:  8c fd c5                JUMP            553f

Routine 577c, 7 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000)

 578b:  2d 05 88                STORE           L04,G78
 578e:  2d 06 86                STORE           L05,G76
 5791:  2d 07 87                STORE           L06,G77
 5794:  c1 6b 0c 03 02 60       JE              #0c,L02,L01 [FALSE] 57b8
 579a:  61 7a 10 dc             JE              G6a,G00 [TRUE] 57b8
 579e:  b2 ...                  PRINT           "I don't see what you are referring to."
 57b5:  bb                      NEW_LINE        
 57b6:  9b 02                   RET             #02
 57b8:  41 02 0c 45             JE              L01,#0c [FALSE] 57bf
 57bc:  2d 02 7b                STORE           L01,G6b
 57bf:  41 03 0c 45             JE              L02,#0c [FALSE] 57c6
 57c3:  2d 03 7b                STORE           L02,G6b
 57c6:  2d 88 01                STORE           G78,L00
 57c9:  2d 86 02                STORE           G76,L01
 57cc:  a0 86 d0                JZ              G76 [TRUE] 57dd
 57cf:  41 87 0c cc             JE              G77,#0c [TRUE] 57dd
 57d3:  41 88 89 c8             JE              G78,#89 [TRUE] 57dd
 57d7:  2d 7b 86                STORE           G6b,G76
 57da:  2d 7a 10                STORE           G6a,G00
 57dd:  2d 87 03                STORE           G77,L02
 57e0:  c1 6b 0b 86 87 4d       JE              #0b,G76,G77 [FALSE] 57f1
 57e6:  e0 3f 27 d1 04          CALL            4fa2 -> L03
 57eb:  a0 04 c5                JZ              L03 [TRUE] 57f1
 57ee:  8c 00 85                JUMP            5874
 57f1:  2d 02 86                STORE           L01,G76
 57f4:  2d 03 87                STORE           L02,G77
 57f7:  51 7f 11 00             GET_PROP        G6f,#11 -> -(SP)
 57fb:  e0 bf 00 04             CALL            (SP)+ -> L03
 57ff:  a0 04 c5                JZ              L03 [TRUE] 5805
 5802:  8c 00 71                JUMP            5874
 5805:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 5808:  51 00 11 00             GET_PROP        (SP)+,#11 -> -(SP)
 580c:  e0 9f 00 01 04          CALL            (SP)+ (#01) -> L03
 5811:  a0 04 c5                JZ              L03 [TRUE] 5817
 5814:  8c 00 5f                JUMP            5874
 5817:  6f ac 01 00             LOADW           G9c,L00 -> -(SP)
 581b:  e0 bf 00 04             CALL            (SP)+ -> L03
 581f:  a0 04 c5                JZ              L03 [TRUE] 5825
 5822:  8c 00 51                JUMP            5874
 5825:  a0 03 d0                JZ              L02 [TRUE] 5836
 5828:  51 03 11 00             GET_PROP        L02,#11 -> -(SP)
 582c:  e0 bf 00 04             CALL            (SP)+ -> L03
 5830:  a0 04 c5                JZ              L03 [TRUE] 5836
 5833:  8c 00 40                JUMP            5874
 5836:  a0 02 dd                JZ              L01 [TRUE] 5854
 5839:  41 01 89 d9             JE              L00,#89 [TRUE] 5854
 583d:  a3 02 00                GET_PARENT      L01 -> -(SP)
 5840:  a0 00 d3                JZ              (SP)+ [TRUE] 5854
 5843:  a3 02 00                GET_PARENT      L01 -> -(SP)
 5846:  51 00 02 00             GET_PROP        (SP)+,#02 -> -(SP)
 584a:  e0 bf 00 04             CALL            (SP)+ -> L03
 584e:  a0 04 c5                JZ              L03 [TRUE] 5854
 5851:  8c 00 22                JUMP            5874
 5854:  a0 02 d4                JZ              L01 [TRUE] 5869
 5857:  41 01 89 d0             JE              L00,#89 [TRUE] 5869
 585b:  51 02 11 00             GET_PROP        L01,#11 -> -(SP)
 585f:  e0 bf 00 04             CALL            (SP)+ -> L03
 5863:  a0 04 c5                JZ              L03 [TRUE] 5869
 5866:  8c 00 0d                JUMP            5874
 5869:  6f ab 01 00             LOADW           G9b,L00 -> -(SP)
 586d:  e0 bf 00 04             CALL            (SP)+ -> L03
 5871:  a0 04 c2                JZ              L03 [TRUE] 5874
 5874:  2d 88 05                STORE           G78,L04
 5877:  2d 86 06                STORE           G76,L05
 587a:  2d 87 07                STORE           G77,L06
 587d:  ab 04                   RET             L03

Routine 5880, 11 locals (0001, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, ffff)

 5897:  05 0b 09 45             INC_CHK         L0a,#09 [FALSE] 589e
 589b:  8c 00 0a                JUMP            58a6
 589e:  e1 a7 74 0b 00          STOREW          G64,L0a,#00
 58a3:  8c ff f3                JUMP            5897
 58a6:  0d 68 00                STORE           G58,#00
 58a9:  0d 78 00                STORE           G68,#00
 58ac:  e1 a7 66 61 00          STOREW          G56,G51,#00
 58b1:  e1 a7 65 61 00          STOREW          G55,G51,#00
 58b6:  e1 a7 64 61 00          STOREW          G54,G51,#00
 58bb:  a0 70 59                JZ              G60 [FALSE] 58d5
 58be:  61 7f 90 d5             JE              G6f,G80 [TRUE] 58d5
 58c2:  2d 7f 90                STORE           G6f,G80
 58c5:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 58c8:  4a 00 1b c5             TEST_ATTR       (SP)+,#1b [TRUE] 58cf
 58cc:  a3 7f 10                GET_PARENT      G6f -> G00
 58cf:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 58d5:  a0 7c d7                JZ              G6c [TRUE] 58ed
 58d8:  2d 01 7c                STORE           L00,G6c
 58db:  a0 56 4b                JZ              G46 [FALSE] 58e7
 58de:  61 90 7f 47             JE              G80,G6f [FALSE] 58e7
 58e2:  41 88 70 c3             JE              G78,#70 [TRUE] 58e7
 58e6:  bb                      NEW_LINE        
 58e7:  0d 7c 00                STORE           G6c,#00
 58ea:  8c 00 25                JUMP            5910
 58ed:  2d 7f 90                STORE           G6f,G80
 58f0:  0d 70 00                STORE           G60,#00
 58f3:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 58f6:  4a 00 1b c5             TEST_ATTR       (SP)+,#1b [TRUE] 58fd
 58fa:  a3 7f 10                GET_PARENT      G6f -> G00
 58fd:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 5903:  a0 56 43                JZ              G46 [FALSE] 5907
 5906:  bb                      NEW_LINE        
 5907:  b2 ...                  PRINT           ">"
 590c:  e4 af 7d 7e             READ            G6d,G6e
 5910:  50 7e 01 81             LOADB           G6e,#01 -> G71
 5914:  a0 81 51                JZ              G71 [FALSE] 5926
 5917:  b2 ...                  PRINT           "I beg your pardon?"
 5924:  bb                      NEW_LINE        
 5925:  b1                      RFALSE          
 5926:  2d 05 81                STORE           L04,G71
 5929:  0d 80 00                STORE           G70,#00
 592c:  0d 71 00                STORE           G61,#00
 592f:  0d 60 00                STORE           G50,#00
 5932:  04 81 00 48             DEC_CHK         G71,#00 [FALSE] 593c
 5936:  0d 70 00                STORE           G60,#00
 5939:  8c 02 35                JUMP            5b6f
 593c:  6f 7e 01 02             LOADW           G6e,L00 -> L01
 5940:  a0 02 4c                JZ              L01 [FALSE] 594d
 5943:  e0 2f 2e dc 01 02       CALL            5db8 (L00) -> L01
 5949:  a0 02 82 13             JZ              L01 [TRUE] 5b5e
 594d:  c1 8f 02 4c 00 4e       JE              L01,"to" [FALSE] 595f
 5953:  41 04 ef 4a             JE              L03,#ef [FALSE] 595f
 5957:  cd 4f 02 3b 3d          STORE           L01,"""
 595c:  8c 00 1d                JUMP            597a
 595f:  c1 8f 02 4b c1 57       JE              L01,"then" [FALSE] 597a
 5965:  a0 04 54                JZ              L03 [FALSE] 597a
 5968:  a0 70 51                JZ              G60 [FALSE] 597a
 596b:  e1 97 74 00 ef          STOREW          G64,#00,#ef
 5970:  e1 97 74 01 00          STOREW          G64,#01,#00
 5975:  cd 4f 02 3b 3d          STORE           L01,"""
 597a:  c1 83 02 4b c1 3b 2f c8 JE              L01,"then","." [TRUE] 5988
 5982:  c1 8f 02 3b 3d 63       JE              L01,""" [FALSE] 59a9
 5988:  c1 8f 02 3b 3d 4e       JE              L01,""" [FALSE] 599a
 598e:  a0 70 c8                JZ              G60 [TRUE] 5997
 5991:  0d 70 00                STORE           G60,#00
 5994:  8c 00 05                JUMP            599a
 5997:  0d 70 01                STORE           G60,#01
 599a:  a0 81 c6                JZ              G71 [TRUE] 59a1
 599d:  54 01 02 7c             ADD             L00,#02 -> G6c
 59a1:  e2 9b 7e 01 81          STOREB          G6e,#01,G71
 59a6:  8c 01 c8                JUMP            5b6f
 59a9:  e0 25 2d d5 02 10 03 03 CALL            5baa (L01,#10,#03) -> L02
 59b1:  a0 03 80 65             JZ              L02 [TRUE] 5a18
 59b5:  c1 97 04 00 f8 00 5e    JE              L03,#00,#f8 [FALSE] 5a18
 59bc:  41 05 01 80 39          JE              L04,#01 [TRUE] 59f8
 59c1:  41 05 02 46             JE              L04,#02 [FALSE] 59c9
 59c5:  41 04 f8 f1             JE              L03,#f8 [TRUE] 59f8
 59c9:  54 01 02 00             ADD             L00,#02 -> -(SP)
 59cd:  6f 7e 00 07             LOADW           G6e,(SP)+ -> L06
 59d1:  c1 80 07 4b c1 3b 2f 3b 3d 46 
                               JE              L06,"then",".",""" [FALSE] 59df
 59db:  42 05 02 5b             JL              L04,#02 [FALSE] 59f8
 59df:  a0 70 cc                JZ              G60 [TRUE] 59ec
 59e2:  41 05 02 48             JE              L04,#02 [FALSE] 59ec
 59e6:  c1 8f 07 3b 3d ce       JE              L06,""" [TRUE] 59f8
 59ec:  43 05 02 6a             JG              L04,#02 [FALSE] 5a18
 59f0:  c1 83 07 3b 36 3b 98 62 JE              L06,",","and" [FALSE] 5a18
 59f8:  2d 06 03                STORE           L05,L02
 59fb:  c1 83 07 3b 36 3b 98 4c JE              L06,",","and" [FALSE] 5a0d
 5a03:  54 01 02 00             ADD             L00,#02 -> -(SP)
 5a07:  e1 a3 7e 00 4b c1       STOREW          G6e,(SP)+,"then"
 5a0d:  43 05 02 81 55          JG              L04,#02 [TRUE] 5b65
 5a12:  0d 70 00                STORE           G60,#00
 5a15:  8c 01 59                JUMP            5b6f
 5a18:  e0 25 2d d5 02 40 01 03 CALL            5baa (L01,#40,#01) -> L02
 5a20:  a0 03 f8                JZ              L02 [TRUE] 5a59
 5a23:  a0 04 75                JZ              L03 [FALSE] 5a59
 5a26:  2d 04 03                STORE           L03,L02
 5a29:  e1 9b 74 00 03          STOREW          G64,#00,L02
 5a2e:  e1 9b 74 01 72          STOREW          G64,#01,G62
 5a33:  e1 9b 72 00 02          STOREW          G62,#00,L01
 5a38:  56 01 02 00             MUL             L00,#02 -> -(SP)
 5a3c:  54 00 02 09             ADD             (SP)+,#02 -> L08
 5a40:  70 7e 09 00             LOADB           G6e,L08 -> -(SP)
 5a44:  e2 9b 72 02 00          STOREB          G62,#02,(SP)+
 5a49:  54 09 01 00             ADD             L08,#01 -> -(SP)
 5a4d:  70 7e 00 00             LOADB           G6e,(SP)+ -> -(SP)
 5a51:  e2 9b 72 03 00          STOREB          G62,#03,(SP)+
 5a56:  8c 01 0e                JUMP            5b65
 5a59:  e0 25 2d d5 02 08 00 03 CALL            5baa (L01,#08,#00) -> L02
 5a61:  a0 03 62                JZ              L02 [FALSE] 5a84
 5a64:  c1 83 02 3b 7c 46 7a d7 JE              L01,"all","one" [TRUE] 5a81
 5a6c:  e0 27 2d d5 02 20 00    CALL            5baa (L01,#20) -> -(SP)
 5a73:  a0 00 4d                JZ              (SP)+ [FALSE] 5a81
 5a76:  e0 27 2d d5 02 80 00    CALL            5baa (L01,#80) -> -(SP)
 5a7d:  a0 00 80 86             JZ              (SP)+ [TRUE] 5b05
 5a81:  0d 03 00                STORE           L02,#00
 5a84:  43 81 00 60             JG              G71,#00 [FALSE] 5aa6
 5a88:  54 01 02 00             ADD             L00,#02 -> -(SP)
 5a8c:  6f 7e 00 00             LOADW           G6e,(SP)+ -> -(SP)
 5a90:  c1 8f 00 46 50 52       JE              (SP)+,"of" [FALSE] 5aa6
 5a96:  a0 03 4f                JZ              L02 [FALSE] 5aa6
 5a99:  c1 80 02 3b 7c 46 7a 3b 44 c5 
                               JE              L01,"all","one","a" [TRUE] 5aa6
 5aa3:  8c 00 c1                JUMP            5b65
 5aa6:  a0 03 e7                JZ              L02 [TRUE] 5ace
 5aa9:  a0 81 d2                JZ              G71 [TRUE] 5abc
 5aac:  54 01 02 00             ADD             L00,#02 -> -(SP)
 5ab0:  6f 7e 00 00             LOADW           G6e,(SP)+ -> -(SP)
 5ab4:  c1 83 00 4b c1 3b 2f 54 JE              (SP)+,"then","." [FALSE] 5ace
 5abc:  42 71 02 00 a6          JL              G61,#02 [FALSE] 5b65
 5ac1:  e1 9b 74 02 03          STOREW          G64,#02,L02
 5ac6:  e1 9b 74 03 02          STOREW          G64,#03,L01
 5acb:  8c 00 99                JUMP            5b65
 5ace:  41 71 02 5d             JE              G61,#02 [FALSE] 5aed
 5ad2:  b2 ...                  PRINT           "There were too many nouns in that sentence."
 5aeb:  bb                      NEW_LINE        
 5aec:  b1                      RFALSE          
 5aed:  95 71                   INC             G61
 5aef:  e0 2a 2d e8 01 03 02 01 CALL            5bd0 (L00,L02,L01) -> L00
 5af7:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 5afa:  42 01 00 00 68          JL              L00,#00 [FALSE] 5b65
 5aff:  0d 70 00                STORE           G60,#00
 5b02:  8c 00 6c                JUMP            5b6f
 5b05:  e0 27 2d d5 02 04 00    CALL            5baa (L01,#04) -> -(SP)
 5b0c:  a0 00 c5                JZ              (SP)+ [TRUE] 5b12
 5b0f:  8c 00 55                JUMP            5b65
 5b12:  41 04 ef 00 42          JE              L03,#ef [FALSE] 5b57
 5b17:  e0 25 2d d5 02 40 01 00 CALL            5baa (L01,#40,#01) -> -(SP)
 5b1f:  a0 00 f7                JZ              (SP)+ [TRUE] 5b57
 5b22:  b2 ...                  PRINT           "Please consult your manual for the correct way to talk to other people or creatures."
 5b55:  bb                      NEW_LINE        
 5b56:  b1                      RFALSE          
 5b57:  e0 2f 30 20 01 00       CALL            6040 (L00) -> -(SP)
 5b5d:  b1                      RFALSE          
 5b5e:  e0 2f 2f f8 01 00       CALL            5ff0 (L00) -> -(SP)
 5b64:  b1                      RFALSE          
 5b65:  2d 08 02                STORE           L07,L01
 5b68:  54 01 02 01             ADD             L00,#02 -> L00
 5b6c:  8c fd c5                JUMP            5932
 5b6f:  a0 06 cd                JZ              L05 [TRUE] 5b7d
 5b72:  0d 88 89                STORE           G78,#89
 5b75:  2d 86 06                STORE           G76,L05
 5b78:  2d 6f 06                STORE           G5f,L05
 5b7b:  9b 01                   RET             #01
 5b7d:  0d 6f 00                STORE           G5f,#00
 5b80:  a0 79 c7                JZ              G69 [TRUE] 5b88
 5b83:  e0 3f 2f 21 00          CALL            5e42 -> -(SP)
 5b88:  e0 3f 30 50 00          CALL            60a0 -> -(SP)
 5b8d:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 5b90:  e0 3f 32 65 00          CALL            64ca -> -(SP)
 5b95:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 5b98:  e0 3f 35 cc 00          CALL            6b98 -> -(SP)
 5b9d:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 5ba0:  e0 3f 35 6c 00          CALL            6ad8 -> -(SP)
 5ba5:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 5ba8:  b0                      RTRUE           

Routine 5baa, 5 locals (0000, 0000, 0005, 0005, 0000)

 5bb5:  50 01 04 05             LOADB           L00,#04 -> L04
 5bb9:  67 05 02 40             TEST            L04,L01 [FALSE] RFALSE
 5bbd:  43 03 04 c1             JG              L02,#04 [TRUE] RTRUE
 5bc1:  49 05 03 05             AND             L04,#03 -> L04
 5bc5:  61 05 03 c4             JE              L04,L02 [TRUE] 5bcb
 5bc9:  95 04                   INC             L03
 5bcb:  70 01 04 00             LOADB           L00,L03 -> -(SP)
 5bcf:  b8                      RET_POPPED      

Routine 5bd0, 10 locals (0000, 0000, 0000, 0000, 0000, 0000, 0001, 0000, 0000, 0000)

 5be5:  55 71 01 00             SUB             G61,#01 -> -(SP)
 5be9:  56 00 02 04             MUL             (SP)+,#02 -> L03
 5bed:  a0 02 db                JZ              L01 [TRUE] 5c09
 5bf0:  34 02 04 05             ADD             #02,L03 -> L04
 5bf4:  e1 ab 74 05 02          STOREW          G64,L04,L01
 5bf9:  54 05 01 00             ADD             L04,#01 -> -(SP)
 5bfd:  e1 ab 74 00 03          STOREW          G64,(SP)+,L02
 5c02:  54 01 02 01             ADD             L00,#02 -> L00
 5c06:  8c 00 04                JUMP            5c0b
 5c09:  95 81                   INC             G71
 5c0b:  a0 81 47                JZ              G71 [FALSE] 5c13
 5c0e:  96 71                   DEC             G61
 5c10:  8b ff ff                RET             #ffff
 5c13:  34 06 04 05             ADD             #06,L03 -> L04
 5c17:  56 01 02 00             MUL             L00,#02 -> -(SP)
 5c1b:  74 7e 00 00             ADD             G6e,(SP)+ -> -(SP)
 5c1f:  e1 ab 74 05 00          STOREW          G64,L04,(SP)+
 5c24:  6f 7e 01 00             LOADW           G6e,L00 -> -(SP)
 5c28:  c1 80 00 4b b3 3b 44 3b 8a 4f 
                               JE              (SP)+,"the","a","an" [FALSE] 5c3f
 5c32:  6f 74 05 00             LOADW           G64,L04 -> -(SP)
 5c36:  54 00 04 00             ADD             (SP)+,#04 -> -(SP)
 5c3a:  e1 ab 74 05 00          STOREW          G64,L04,(SP)+
 5c3f:  04 81 00 56             DEC_CHK         G71,#00 [FALSE] 5c57
 5c43:  54 05 01 0a             ADD             L04,#01 -> L09
 5c47:  56 01 02 00             MUL             L00,#02 -> -(SP)
 5c4b:  74 7e 00 00             ADD             G6e,(SP)+ -> -(SP)
 5c4f:  e1 ab 74 0a 00          STOREW          G64,L09,(SP)+
 5c54:  8b ff ff                RET             #ffff
 5c57:  6f 7e 01 03             LOADW           G6e,L00 -> L02
 5c5b:  a0 03 4c                JZ              L02 [FALSE] 5c68
 5c5e:  e0 2f 2e dc 01 03       CALL            5db8 (L00) -> L02
 5c64:  a0 03 81 3e             JZ              L02 [TRUE] 5da4
 5c68:  a0 81 48                JZ              G71 [FALSE] 5c71
 5c6b:  0d 08 00                STORE           L07,#00
 5c6e:  8c 00 0a                JUMP            5c79
 5c71:  54 01 02 00             ADD             L00,#02 -> -(SP)
 5c75:  6f 7e 00 08             LOADW           G6e,(SP)+ -> L07
 5c79:  c1 83 03 3b 98 3b 36 48 JE              L02,"and","," [FALSE] 5c87
 5c81:  0d 06 01                STORE           L05,#01
 5c84:  8c 01 26                JUMP            5dab
 5c87:  c1 83 03 3b 7c 46 7a 52 JE              L02,"all","one" [FALSE] 5c9f
 5c8f:  c1 8f 08 46 50 01 17    JE              L07,"of" [FALSE] 5dab
 5c96:  96 81                   DEC             G71
 5c98:  54 01 02 01             ADD             L00,#02 -> L00
 5c9c:  8c 01 0e                JUMP            5dab
 5c9f:  c1 83 03 4b c1 3b 2f d6 JE              L02,"then","." [TRUE] 5cbb
 5ca7:  e0 27 2d d5 03 08 00    CALL            5baa (L02,#08) -> -(SP)
 5cae:  a0 00 e5                JZ              (SP)+ [TRUE] 5cd4
 5cb1:  4f 74 00 00             LOADW           G64,#00 -> -(SP)
 5cb5:  a0 00 de                JZ              (SP)+ [TRUE] 5cd4
 5cb8:  a0 07 5b                JZ              L06 [FALSE] 5cd4
 5cbb:  95 81                   INC             G71
 5cbd:  54 05 01 0a             ADD             L04,#01 -> L09
 5cc1:  56 01 02 00             MUL             L00,#02 -> -(SP)
 5cc5:  74 7e 00 00             ADD             G6e,(SP)+ -> -(SP)
 5cc9:  e1 ab 74 0a 00          STOREW          G64,L09,(SP)+
 5cce:  55 01 02 00             SUB             L00,#02 -> -(SP)
 5cd2:  ab 00                   RET             (SP)+
 5cd4:  e0 27 2d d5 03 80 00    CALL            5baa (L02,#80) -> -(SP)
 5cdb:  a0 00 80 62             JZ              (SP)+ [TRUE] 5d3f
 5cdf:  43 81 00 53             JG              G71,#00 [FALSE] 5cf4
 5ce3:  c1 8f 08 46 50 4d       JE              L07,"of" [FALSE] 5cf4
 5ce9:  c1 83 03 3b 7c 46 7a c5 JE              L02,"all","one" [TRUE] 5cf4
 5cf1:  8c 00 b9                JUMP            5dab
 5cf4:  e0 25 2d d5 03 20 02 00 CALL            5baa (L02,#20,#02) -> -(SP)
 5cfc:  a0 00 d2                JZ              (SP)+ [TRUE] 5d0f
 5cff:  a0 08 cf                JZ              L07 [TRUE] 5d0f
 5d02:  e0 27 2d d5 08 80 00    CALL            5baa (L07,#80) -> -(SP)
 5d09:  a0 00 c5                JZ              (SP)+ [TRUE] 5d0f
 5d0c:  8c 00 9e                JUMP            5dab
 5d0f:  a0 06 69                JZ              L05 [FALSE] 5d39
 5d12:  c1 83 08 3d 97 40 61 e1 JE              L07,"but","except" [TRUE] 5d39
 5d1a:  c1 83 08 3b 98 3b 36 d9 JE              L07,"and","," [TRUE] 5d39
 5d22:  54 05 01 0a             ADD             L04,#01 -> L09
 5d26:  54 01 02 00             ADD             L00,#02 -> -(SP)
 5d2a:  56 00 02 00             MUL             (SP)+,#02 -> -(SP)
 5d2e:  74 7e 00 00             ADD             G6e,(SP)+ -> -(SP)
 5d32:  e1 ab 74 0a 00          STOREW          G64,L09,(SP)+
 5d37:  ab 01                   RET             L00
 5d39:  0d 06 00                STORE           L05,#00
 5d3c:  8c 00 6e                JUMP            5dab
 5d3f:  a0 78 4c                JZ              G68 [FALSE] 5d4c
 5d42:  a0 79 49                JZ              G69 [FALSE] 5d4c
 5d45:  4f 74 00 00             LOADW           G64,#00 -> -(SP)
 5d49:  a0 00 da                JZ              (SP)+ [TRUE] 5d64
 5d4c:  e0 27 2d d5 03 20 00    CALL            5baa (L02,#20) -> -(SP)
 5d53:  a0 00 00 56             JZ              (SP)+ [FALSE] 5dab
 5d57:  e0 27 2d d5 03 04 00    CALL            5baa (L02,#04) -> -(SP)
 5d5e:  a0 00 c5                JZ              (SP)+ [TRUE] 5d64
 5d61:  8c 00 49                JUMP            5dab
 5d64:  a0 06 eb                JZ              L05 [TRUE] 5d90
 5d67:  e0 27 2d d5 03 10 00    CALL            5baa (L02,#10) -> -(SP)
 5d6e:  a0 00 4c                JZ              (SP)+ [FALSE] 5d7b
 5d71:  e0 27 2d d5 03 40 00    CALL            5baa (L02,#40) -> -(SP)
 5d78:  a0 00 d7                JZ              (SP)+ [TRUE] 5d90
 5d7b:  55 01 04 01             SUB             L00,#04 -> L00
 5d7f:  54 01 02 00             ADD             L00,#02 -> -(SP)
 5d83:  e1 a3 7e 00 4b c1       STOREW          G6e,(SP)+,"then"
 5d89:  54 81 02 81             ADD             G71,#02 -> G71
 5d8d:  8c 00 1d                JUMP            5dab
 5d90:  e0 27 2d d5 03 08 00    CALL            5baa (L02,#08) -> -(SP)
 5d97:  a0 00 c5                JZ              (SP)+ [TRUE] 5d9d
 5d9a:  8c 00 10                JUMP            5dab
 5d9d:  e0 2f 30 20 01 00       CALL            6040 (L00) -> -(SP)
 5da3:  b1                      RFALSE          
 5da4:  e0 2f 2f f8 01 00       CALL            5ff0 (L00) -> -(SP)
 5daa:  b1                      RFALSE          
 5dab:  2d 09 03                STORE           L08,L02
 5dae:  0d 07 00                STORE           L06,#00
 5db1:  54 01 02 01             ADD             L00,#02 -> L00
 5db5:  8c fe 89                JUMP            5c3f

Routine 5db8, 7 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000)

 5dc7:  56 01 02 00             MUL             L00,#02 -> -(SP)
 5dcb:  74 7e 00 00             ADD             G6e,(SP)+ -> -(SP)
 5dcf:  50 00 02 02             LOADB           (SP)+,#02 -> L01
 5dd3:  56 01 02 00             MUL             L00,#02 -> -(SP)
 5dd7:  74 7e 00 00             ADD             G6e,(SP)+ -> -(SP)
 5ddb:  50 00 03 03             LOADB           (SP)+,#03 -> L02
 5ddf:  04 02 00 45             DEC_CHK         L01,#00 [FALSE] 5de6
 5de3:  8c 00 32                JUMP            5e16
 5de6:  70 7d 03 04             LOADB           G6d,L02 -> L03
 5dea:  41 04 3a 4b             JE              L03,#3a [FALSE] 5df7
 5dee:  2d 06 05                STORE           L05,L04
 5df1:  0d 05 00                STORE           L04,#00
 5df4:  8c 00 1c                JUMP            5e11
 5df7:  c3 8f 05 27 10 c0       JG              L04,#2710 [TRUE] RFALSE
 5dfd:  42 04 3a 40             JL              L03,#3a [FALSE] RFALSE
 5e01:  43 04 2f 40             JG              L03,#2f [FALSE] RFALSE
 5e05:  56 05 0a 07             MUL             L04,#0a -> L06
 5e09:  55 04 30 00             SUB             L03,#30 -> -(SP)
 5e0d:  74 07 00 05             ADD             L06,(SP)+ -> L04
 5e11:  95 03                   INC             L02
 5e13:  8c ff cb                JUMP            5ddf
 5e16:  e1 a3 7e 01 43 a9       STOREW          G6e,L00,"intnum"
 5e1c:  c3 8f 05 03 e8 c0       JG              L04,#03e8 [TRUE] RFALSE
 5e22:  a0 06 d9                JZ              L05 [TRUE] 5e3c
 5e25:  42 06 08 49             JL              L05,#08 [FALSE] 5e30
 5e29:  54 06 0c 06             ADD             L05,#0c -> L05
 5e2d:  8c 00 06                JUMP            5e34
 5e30:  43 06 17 c0             JG              L05,#17 [TRUE] RFALSE
 5e34:  56 06 3c 00             MUL             L05,#3c -> -(SP)
 5e38:  74 05 00 05             ADD             L04,(SP)+ -> L04
 5e3c:  2d 6e 05                STORE           G5e,L04
 5e3f:  8b 43 a9                RET             "intnum"

Routine 5e42, 8 locals (ffff, 0000, 0000, 0000, 0000, 0000, 0000, 0000)

 5e53:  0d 79 00                STORE           G69,#00
 5e56:  4f 74 01 00             LOADW           G64,#01 -> -(SP)
 5e5a:  4f 00 00 00             LOADW           (SP)+,#00 -> -(SP)
 5e5e:  e0 25 2d d5 00 20 02 00 CALL            5baa ((SP)+,#20,#02) -> -(SP)
 5e66:  a0 00 c5                JZ              (SP)+ [TRUE] 5e6c
 5e69:  0d 06 01                STORE           L05,#01
 5e6c:  4f 74 00 03             LOADW           G64,#00 -> L02
 5e70:  a0 03 cd                JZ              L02 [TRUE] 5e7e
 5e73:  a0 06 4a                JZ              L05 [FALSE] 5e7e
 5e76:  4f 73 00 00             LOADW           G63,#00 -> -(SP)
 5e7a:  61 03 00 40             JE              L02,(SP)+ [FALSE] RFALSE
 5e7e:  41 71 02 c0             JE              G61,#02 [TRUE] RFALSE
 5e82:  4f 73 06 00             LOADW           G63,#06 -> -(SP)
 5e86:  41 00 01 00 3e          JE              (SP)+,#01 [FALSE] 5ec7
 5e8b:  4f 74 02 02             LOADW           G64,#02 -> L01
 5e8f:  4f 73 02 00             LOADW           G63,#02 -> -(SP)
 5e93:  61 02 00 c5             JE              L01,(SP)+ [TRUE] 5e9a
 5e97:  a0 02 40                JZ              L01 [FALSE] RFALSE
 5e9a:  a0 06 d7                JZ              L05 [TRUE] 5eb2
 5e9d:  54 7e 02 00             ADD             G6e,#02 -> -(SP)
 5ea1:  e1 9b 73 06 00          STOREW          G63,#06,(SP)+
 5ea6:  54 7e 06 00             ADD             G6e,#06 -> -(SP)
 5eaa:  e1 9b 73 07 00          STOREW          G63,#07,(SP)+
 5eaf:  8c 00 eb                JUMP            5f9b
 5eb2:  4f 74 06 00             LOADW           G64,#06 -> -(SP)
 5eb6:  e1 9b 73 06 00          STOREW          G63,#06,(SP)+
 5ebb:  4f 74 07 00             LOADW           G64,#07 -> -(SP)
 5ebf:  e1 9b 73 07 00          STOREW          G63,#07,(SP)+
 5ec4:  8c 00 d6                JUMP            5f9b
 5ec7:  4f 73 08 00             LOADW           G63,#08 -> -(SP)
 5ecb:  41 00 01 00 3e          JE              (SP)+,#01 [FALSE] 5f0c
 5ed0:  4f 74 02 02             LOADW           G64,#02 -> L01
 5ed4:  4f 73 04 00             LOADW           G63,#04 -> -(SP)
 5ed8:  61 02 00 c5             JE              L01,(SP)+ [TRUE] 5edf
 5edc:  a0 02 40                JZ              L01 [FALSE] RFALSE
 5edf:  a0 06 d4                JZ              L05 [TRUE] 5ef4
 5ee2:  54 7e 02 00             ADD             G6e,#02 -> -(SP)
 5ee6:  e1 9b 74 06 00          STOREW          G64,#06,(SP)+
 5eeb:  54 7e 06 00             ADD             G6e,#06 -> -(SP)
 5eef:  e1 9b 74 07 00          STOREW          G64,#07,(SP)+
 5ef4:  4f 74 06 00             LOADW           G64,#06 -> -(SP)
 5ef8:  e1 9b 73 08 00          STOREW          G63,#08,(SP)+
 5efd:  4f 74 07 00             LOADW           G64,#07 -> -(SP)
 5f01:  e1 9b 73 09 00          STOREW          G63,#09,(SP)+
 5f06:  0d 71 02                STORE           G61,#02
 5f09:  8c 00 91                JUMP            5f9b
 5f0c:  a0 77 80 8d             JZ              G67 [TRUE] 5f9b
 5f10:  41 71 01 c9             JE              G61,#01 [TRUE] 5f1b
 5f14:  a0 06 46                JZ              L05 [FALSE] 5f1b
 5f17:  0d 77 00                STORE           G67,#00
 5f1a:  b1                      RFALSE          
 5f1b:  4f 74 06 04             LOADW           G64,#06 -> L03
 5f1f:  a0 06 c9                JZ              L05 [TRUE] 5f29
 5f22:  54 7e 02 04             ADD             G6e,#02 -> L03
 5f26:  0d 06 00                STORE           L05,#00
 5f29:  4f 74 07 05             LOADW           G64,#07 -> L04
 5f2d:  4f 04 00 07             LOADW           L03,#00 -> L06
 5f31:  61 04 05 52             JE              L03,L04 [FALSE] 5f45
 5f35:  a0 06 cb                JZ              L05 [TRUE] 5f41
 5f38:  e0 2f 2f d8 06 00       CALL            5fb0 (L05) -> -(SP)
 5f3e:  8c 00 5c                JUMP            5f9b
 5f41:  0d 77 00                STORE           G67,#00
 5f44:  b1                      RFALSE          
 5f45:  a0 06 58                JZ              L05 [FALSE] 5f5e
 5f48:  50 07 04 00             LOADB           L06,#04 -> -(SP)
 5f4c:  47 00 20 ca             TEST            (SP)+,#20 [TRUE] 5f58
 5f50:  c1 83 07 3b 7c 46 7a 48 JE              L06,"all","one" [FALSE] 5f5e
 5f58:  2d 06 07                STORE           L05,L06
 5f5b:  8c 00 20                JUMP            5f7c
 5f5e:  50 07 04 00             LOADB           L06,#04 -> -(SP)
 5f62:  47 00 80 c8             TEST            (SP)+,#80 [TRUE] 5f6c
 5f66:  c1 8f 07 46 7a 52       JE              L06,"one" [FALSE] 5f7c
 5f6c:  c1 a3 07 76 46 7a 40    JE              L06,G66,"one" [FALSE] RFALSE
 5f73:  e0 2f 2f d8 06 00       CALL            5fb0 (L05) -> -(SP)
 5f79:  8c 00 21                JUMP            5f9b
 5f7c:  54 04 04 04             ADD             L03,#04 -> L03
 5f80:  a0 05 3f ab             JZ              L04 [FALSE] 5f2d
 5f84:  2d 05 04                STORE           L04,L03
 5f87:  0d 71 01                STORE           G61,#01
 5f8a:  55 04 04 00             SUB             L03,#04 -> -(SP)
 5f8e:  e1 9b 74 06 00          STOREW          G64,#06,(SP)+
 5f93:  e1 9b 74 07 04          STOREW          G64,#07,L03
 5f98:  8c ff 94                JUMP            5f2d
 5f9b:  05 01 09 46             INC_CHK         L00,#09 [FALSE] 5fa3
 5f9f:  0d 78 01                STORE           G68,#01
 5fa2:  b0                      RTRUE           
 5fa3:  6f 73 01 00             LOADW           G63,L00 -> -(SP)
 5fa7:  e1 ab 74 01 00          STOREW          G64,L00,(SP)+
 5fac:  8c ff ee                JUMP            5f9b

Routine 5fb0, 1 local (0000)

 5fb3:  4f 73 00 00             LOADW           G63,#00 -> -(SP)
 5fb7:  e1 9b 74 00 00          STOREW          G64,#00,(SP)+
 5fbc:  2d 82 73                STORE           G72,G63
 5fbf:  54 77 01 00             ADD             G67,#01 -> -(SP)
 5fc3:  e0 2a 31 cf 77 00 01 00 CALL            639e (G67,(SP)+,L00) -> -(SP)
 5fcb:  4f 73 08 00             LOADW           G63,#08 -> -(SP)
 5fcf:  a0 00 c5                JZ              (SP)+ [TRUE] 5fd5
 5fd2:  0d 71 02                STORE           G61,#02
 5fd5:  0d 77 00                STORE           G67,#00
 5fd8:  b0                      RTRUE           

Routine 5fda, 2 locals (0000, 0000)

 5fdf:  04 01 00 c1             DEC_CHK         L00,#00 [TRUE] RTRUE
 5fe3:  70 7d 02 00             LOADB           G6d,L01 -> -(SP)
 5fe7:  e5 bf 00                PRINT_CHAR      (SP)+
 5fea:  95 02                   INC             L01
 5fec:  8c ff f2                JUMP            5fdf

Routine 5ff0, 3 locals (0000, 0000, 0000)

 5ff7:  41 88 70 51             JE              G78,#70 [FALSE] 600a
 5ffb:  b2 ...                  PRINT           "Nothing happens."
 6008:  bb                      NEW_LINE        
 6009:  b1                      RFALSE          
 600a:  b2 ...                  PRINT           "I don't know the word ""
 6017:  56 01 02 02             MUL             L00,#02 -> L01
 601b:  74 7e 02 00             ADD             G6e,L01 -> -(SP)
 601f:  50 00 02 03             LOADB           (SP)+,#02 -> L02
 6023:  74 7e 02 00             ADD             G6e,L01 -> -(SP)
 6027:  50 00 03 00             LOADB           (SP)+,#03 -> -(SP)
 602b:  e0 2b 2f ed 03 00 00    CALL            5fda (L02,(SP)+) -> -(SP)
 6032:  b2 ...                  PRINT           ""."
 6037:  bb                      NEW_LINE        
 6038:  0d 70 00                STORE           G60,#00
 603b:  0d 79 00                STORE           G69,#00
 603e:  ab 79                   RET             G69

Routine 6040, 3 locals (0000, 0000, 0000)

 6047:  41 88 70 51             JE              G78,#70 [FALSE] 605a
 604b:  b2 ...                  PRINT           "Nothing happens."
 6058:  bb                      NEW_LINE        
 6059:  b1                      RFALSE          
 605a:  b2 ...                  PRINT           "You used the word ""
 6067:  56 01 02 02             MUL             L00,#02 -> L01
 606b:  74 7e 02 00             ADD             G6e,L01 -> -(SP)
 606f:  50 00 02 03             LOADB           (SP)+,#02 -> L02
 6073:  74 7e 02 00             ADD             G6e,L01 -> -(SP)
 6077:  50 00 03 00             LOADB           (SP)+,#03 -> -(SP)
 607b:  e0 2b 2f ed 03 00 00    CALL            5fda (L02,(SP)+) -> -(SP)
 6082:  b2 ...                  PRINT           "" in a way that I don't understand."
 6097:  bb                      NEW_LINE        
 6098:  0d 70 00                STORE           G60,#00
 609b:  0d 79 00                STORE           G69,#00
 609e:  ab 79                   RET             G69

Routine 60a0, 11 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000)

 60b7:  4f 74 00 08             LOADW           G64,#00 -> L07
 60bb:  a0 08 59                JZ              L07 [FALSE] 60d5
 60be:  b2 ...                  PRINT           "There was no verb in that sentence!"
 60d3:  bb                      NEW_LINE        
 60d4:  b1                      RFALSE          
 60d5:  35 ff 08 00             SUB             #ff,L07 -> -(SP)
 60d9:  6f ad 00 01             LOADW           G9d,(SP)+ -> L00
 60dd:  50 01 00 02             LOADB           L00,#00 -> L01
 60e1:  34 01 01 01             ADD             #01,L00 -> L00
 60e5:  50 01 00 00             LOADB           L00,#00 -> -(SP)
 60e9:  49 00 03 03             AND             (SP)+,#03 -> L02
 60ed:  63 71 03 45             JG              G61,L02 [FALSE] 60f4
 60f1:  8c 00 4b                JUMP            613d
 60f4:  42 03 01 da             JL              L02,#01 [TRUE] 6110
 60f8:  a0 71 57                JZ              G61 [FALSE] 6110
 60fb:  4f 74 02 07             LOADW           G64,#02 -> L06
 60ff:  a0 07 ca                JZ              L06 [TRUE] 610a
 6102:  50 01 01 00             LOADB           L00,#01 -> -(SP)
 6106:  61 07 00 48             JE              L06,(SP)+ [FALSE] 6110
 610a:  2d 05 01                STORE           L04,L00
 610d:  8c 00 2f                JUMP            613d
 6110:  50 01 01 0b             LOADB           L00,#01 -> L0a
 6114:  4f 74 02 00             LOADW           G64,#02 -> -(SP)
 6118:  61 0b 00 63             JE              L0a,(SP)+ [FALSE] 613d
 611c:  41 03 02 4c             JE              L02,#02 [FALSE] 612a
 6120:  41 71 01 48             JE              G61,#01 [FALSE] 612a
 6124:  2d 06 01                STORE           L05,L00
 6127:  8c 00 15                JUMP            613d
 612a:  50 01 02 0b             LOADB           L00,#02 -> L0a
 612e:  4f 74 04 00             LOADW           G64,#04 -> -(SP)
 6132:  61 0b 00 49             JE              L0a,(SP)+ [FALSE] 613d
 6136:  e0 2f 32 25 01 00       CALL            644a (L00) -> -(SP)
 613c:  b0                      RTRUE           
 613d:  04 02 01 68             DEC_CHK         L01,#01 [FALSE] 6167
 6141:  a0 05 6c                JZ              L04 [FALSE] 616e
 6144:  a0 06 c5                JZ              L05 [TRUE] 614a
 6147:  8c 00 26                JUMP            616e
 614a:  b2 ...                  PRINT           "That sentence isn't one I recognize."
 6165:  bb                      NEW_LINE        
 6166:  b1                      RFALSE          
 6167:  54 01 08 01             ADD             L00,#08 -> L00
 616b:  8c ff 79                JUMP            60e5
 616e:  a0 05 ea                JZ              L04 [TRUE] 6199
 6171:  50 05 03 0a             LOADB           L04,#03 -> L09
 6175:  50 05 05 0b             LOADB           L04,#05 -> L0a
 6179:  50 05 01 00             LOADB           L04,#01 -> -(SP)
 617d:  e0 2a 32 2b 0a 0b 00 04 CALL            6456 (L09,L0a,(SP)+) -> L03
 6185:  a0 04 d3                JZ              L03 [TRUE] 6199
 6188:  e1 a7 66 61 01          STOREW          G56,G51,#01
 618d:  e1 9b 66 01 04          STOREW          G56,#01,L03
 6192:  e0 2f 32 25 05 00       CALL            644a (L04) -> -(SP)
 6198:  b8                      RET_POPPED      
 6199:  a0 06 ea                JZ              L05 [TRUE] 61c4
 619c:  50 06 04 0a             LOADB           L05,#04 -> L09
 61a0:  50 06 06 0b             LOADB           L05,#06 -> L0a
 61a4:  50 06 02 00             LOADB           L05,#02 -> -(SP)
 61a8:  e0 2a 32 2b 0a 0b 00 04 CALL            6456 (L09,L0a,(SP)+) -> L03
 61b0:  a0 04 d3                JZ              L03 [TRUE] 61c4
 61b3:  e1 a7 65 61 01          STOREW          G55,G51,#01
 61b8:  e1 9b 65 01 04          STOREW          G55,#01,L03
 61bd:  e0 2f 32 25 06 00       CALL            644a (L05) -> -(SP)
 61c3:  b8                      RET_POPPED      
 61c4:  41 08 ac 59             JE              L07,#ac [FALSE] 61df
 61c8:  b2 ...                  PRINT           "That question can't be answered."
 61dd:  bb                      NEW_LINE        
 61de:  b1                      RFALSE          
 61df:  61 7f 90 c8             JE              G6f,G80 [TRUE] 61e9
 61e3:  e0 3f 31 2b 00          CALL            6256 -> -(SP)
 61e8:  b8                      RET_POPPED      
 61e9:  e0 2b 31 3c 05 06 00    CALL            6278 (L04,L05) -> -(SP)
 61f0:  b2 ...                  PRINT           "What do you want to "
 61fd:  4f 73 01 09             LOADW           G63,#01 -> L08
 6201:  a0 09 4a                JZ              L08 [FALSE] 620c
 6204:  b2 ...                  PRINT           "tell"
 6209:  8c 00 26                JUMP            6230
 620c:  50 72 02 00             LOADB           G62,#02 -> -(SP)
 6210:  a0 00 4b                JZ              (SP)+ [FALSE] 621c
 6213:  4f 09 00 00             LOADW           L08,#00 -> -(SP)
 6217:  a7 00                   PRINT_ADDR      (SP)+
 6219:  8c 00 16                JUMP            6230
 621c:  50 09 02 0b             LOADB           L08,#02 -> L0a
 6220:  50 09 03 00             LOADB           L08,#03 -> -(SP)
 6224:  e0 2b 2f ed 0b 00 00    CALL            5fda (L0a,(SP)+) -> -(SP)
 622b:  e2 97 72 02 00          STOREB          G62,#02,#00
 6230:  a0 06 c9                JZ              L05 [TRUE] 623a
 6233:  e0 17 31 6a 06 07 00    CALL            62d4 (#06,#07) -> -(SP)
 623a:  0d 79 01                STORE           G69,#01
 623d:  a0 05 c9                JZ              L04 [TRUE] 6247
 6240:  50 05 01 00             LOADB           L04,#01 -> -(SP)
 6244:  8c 00 06                JUMP            624b
 6247:  50 06 02 00             LOADB           L05,#02 -> -(SP)
 624b:  e0 2f 31 c5 00 00       CALL            638a ((SP)+) -> -(SP)
 6251:  b2 ...                  PRINT           "?"
 6254:  bb                      NEW_LINE        
 6255:  b1                      RFALSE          

Routine 6256, 0 locals ()

 6257:  b2 ...                  PRINT           ""I don't understand! What are you referring to?""
 6276:  bb                      NEW_LINE        
 6277:  b1                      RFALSE          

Routine 6278, 3 locals (0000, 0000, ffff)

 627f:  e1 a7 62 61 00          STOREW          G52,G51,#00
 6284:  2d 82 74                STORE           G72,G64
 6287:  05 03 09 45             INC_CHK         L02,#09 [FALSE] 628e
 628b:  8c 00 0e                JUMP            629a
 628e:  6f 74 03 00             LOADW           G64,L02 -> -(SP)
 6292:  e1 ab 73 03 00          STOREW          G63,L02,(SP)+
 6297:  8c ff ef                JUMP            6287
 629a:  41 71 02 49             JE              G61,#02 [FALSE] 62a5
 629e:  e0 17 31 cf 08 09 00    CALL            639e (#08,#09) -> -(SP)
 62a5:  42 71 01 c9             JL              G61,#01 [TRUE] 62b0
 62a9:  e0 17 31 cf 06 07 00    CALL            639e (#06,#07) -> -(SP)
 62b0:  a0 01 d1                JZ              L00 [TRUE] 62c2
 62b3:  50 01 01 00             LOADB           L00,#01 -> -(SP)
 62b7:  e1 9b 73 02 00          STOREW          G63,#02,(SP)+
 62bc:  e1 97 73 06 01          STOREW          G63,#06,#01
 62c1:  b0                      RTRUE           
 62c2:  a0 02 c0                JZ              L01 [TRUE] RFALSE
 62c5:  50 02 02 00             LOADB           L01,#02 -> -(SP)
 62c9:  e1 9b 73 04 00          STOREW          G63,#04,(SP)+
 62ce:  e1 97 73 08 01          STOREW          G63,#08,#01
 62d3:  b0                      RTRUE           

Routine 62d4, 4 locals (0000, 0000, 0001, 0000)

 62dd:  6f 74 01 04             LOADW           G64,L00 -> L03
 62e1:  6f 74 02 00             LOADW           G64,L01 -> -(SP)
 62e5:  e0 2a 31 77 04 00 03 00 CALL            62ee (L03,(SP)+,L02) -> -(SP)
 62ed:  b8                      RET_POPPED      

Routine 62ee, 8 locals (0000, 0000, 0000, 0000, 0000, 0001, 0000, 0000)

 62ff:  61 01 02 c1             JE              L00,L01 [TRUE] RTRUE
 6303:  a0 04 c8                JZ              L03 [TRUE] 630c
 6306:  0d 04 00                STORE           L03,#00
 6309:  8c 00 05                JUMP            630f
 630c:  b2 ...                  PRINT           " "
 630f:  4f 01 00 05             LOADW           L00,#00 -> L04
 6313:  c1 8f 05 3b 2f 48       JE              L04,"." [FALSE] 631f
 6319:  0d 04 01                STORE           L03,#01
 631c:  8c 00 3a                JUMP            6357
 631f:  a0 06 cb                JZ              L05 [TRUE] 632b
 6322:  a0 07 48                JZ              L06 [FALSE] 632b
 6325:  a0 03 c5                JZ              L02 [TRUE] 632b
 6328:  b2 ...                  PRINT           "the "
 632b:  a0 79 45                JZ              G69 [FALSE] 6331
 632e:  a0 78 c7                JZ              G68 [TRUE] 6336
 6331:  a7 05                   PRINT_ADDR      L04
 6333:  8c 00 20                JUMP            6354
 6336:  c1 8f 05 43 cc 4b       JE              L04,"it" [FALSE] 6345
 633c:  61 7a 10 47             JE              G6a,G00 [FALSE] 6345
 6340:  aa 7b                   PRINT_OBJ       G6b
 6342:  8c 00 11                JUMP            6354
 6345:  50 01 02 08             LOADB           L00,#02 -> L07
 6349:  50 01 03 00             LOADB           L00,#03 -> -(SP)
 634d:  e0 2b 2f ed 08 00 00    CALL            5fda (L07,(SP)+) -> -(SP)
 6354:  0d 06 00                STORE           L05,#00
 6357:  54 01 04 01             ADD             L00,#04 -> L00
 635b:  8c ff a3                JUMP            62ff

Routine 635e, 2 locals (0000, 0000)

 6363:  50 01 03 00             LOADB           L00,#03 -> -(SP)
 6367:  70 7d 00 00             LOADB           G6d,(SP)+ -> -(SP)
 636b:  55 00 20 00             SUB             (SP)+,#20 -> -(SP)
 636f:  e5 bf 00                PRINT_CHAR      (SP)+
 6372:  50 01 02 00             LOADB           L00,#02 -> -(SP)
 6376:  55 00 01 02             SUB             (SP)+,#01 -> L01
 637a:  50 01 03 00             LOADB           L00,#03 -> -(SP)
 637e:  54 00 01 00             ADD             (SP)+,#01 -> -(SP)
 6382:  e0 2b 2f ed 02 00 00    CALL            5fda (L01,(SP)+) -> -(SP)
 6389:  b8                      RET_POPPED      

Routine 638a, 2 locals (0000, 0000)

 638f:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 6392:  b2 ...                  PRINT           " "
 6395:  e0 2f 32 12 01 02       CALL            6424 (L00) -> L01
 639b:  a7 02                   PRINT_ADDR      L01
 639d:  b0                      RTRUE           

Routine 639e, 5 locals (0000, 0000, 0000, 0000, 0000)

 63a9:  6f 82 01 04             LOADW           G72,L00 -> L03
 63ad:  6f 82 02 05             LOADW           G72,L01 -> L04
 63b1:  6f 62 61 00             LOADW           G52,G51 -> -(SP)
 63b5:  56 00 02 00             MUL             (SP)+,#02 -> -(SP)
 63b9:  54 00 02 00             ADD             (SP)+,#02 -> -(SP)
 63bd:  74 62 00 00             ADD             G52,(SP)+ -> -(SP)
 63c1:  e1 ab 73 01 00          STOREW          G63,L00,(SP)+
 63c6:  61 04 05 58             JE              L03,L04 [FALSE] 63e0
 63ca:  6f 62 61 00             LOADW           G52,G51 -> -(SP)
 63ce:  56 00 02 00             MUL             (SP)+,#02 -> -(SP)
 63d2:  54 00 02 00             ADD             (SP)+,#02 -> -(SP)
 63d6:  74 62 00 00             ADD             G52,(SP)+ -> -(SP)
 63da:  e1 ab 73 02 00          STOREW          G63,L01,(SP)+
 63df:  b0                      RTRUE           
 63e0:  a0 03 d0                JZ              L02 [TRUE] 63f1
 63e3:  4f 04 00 00             LOADW           L03,#00 -> -(SP)
 63e7:  61 76 00 48             JE              G66,(SP)+ [FALSE] 63f1
 63eb:  e0 2f 32 01 03 00       CALL            6402 (L02) -> -(SP)
 63f1:  4f 04 00 00             LOADW           L03,#00 -> -(SP)
 63f5:  e0 2f 32 01 00 00       CALL            6402 ((SP)+) -> -(SP)
 63fb:  54 04 04 04             ADD             L03,#04 -> L03
 63ff:  8c ff c6                JUMP            63c6

Routine 6402, 2 locals (0000, 0000)

 6407:  6f 62 61 00             LOADW           G52,G51 -> -(SP)
 640b:  54 00 02 02             ADD             (SP)+,#02 -> L01
 640f:  55 02 01 00             SUB             L01,#01 -> -(SP)
 6413:  e1 ab 62 00 01          STOREW          G52,(SP)+,L00
 6418:  e1 a7 62 02 00          STOREW          G52,L01,#00
 641d:  e1 ab 62 61 02          STOREW          G52,G51,L01
 6422:  b0                      RTRUE           

Routine 6424, 3 locals (0000, 0000, 0000)

 642b:  4f aa 00 00             LOADW           G9a,#00 -> -(SP)
 642f:  56 00 02 03             MUL             (SP)+,#02 -> L02
 6433:  25 02 03 c0             INC_CHK         L01,L02 [TRUE] RFALSE
 6437:  6f aa 02 00             LOADW           G9a,L01 -> -(SP)
 643b:  61 00 01 3f f5          JE              (SP)+,L00 [FALSE] 6433
 6440:  55 02 01 00             SUB             L01,#01 -> -(SP)
 6444:  6f aa 00 00             LOADW           G9a,(SP)+ -> -(SP)
 6448:  ab 00                   RET             (SP)+

Routine 644a, 1 local (0000)

 644d:  2d 83 01                STORE           G73,L00
 6450:  50 01 07 88             LOADB           L00,#07 -> G78
 6454:  ab 88                   RET             G78

Routine 6456, 4 locals (0000, 0000, 0000, 0000)

 645f:  41 01 12 44             JE              L00,#12 [FALSE] 6465
 6463:  9b 52                   RET             #52
 6465:  2d 6b 01                STORE           G5b,L00
 6468:  2d 6c 02                STORE           G5c,L01
 646b:  e1 a7 63 61 00          STOREW          G53,G51,#00
 6470:  e0 27 33 61 63 00 00    CALL            66c2 (G53,#00) -> -(SP)
 6477:  a0 00 80 4c             JZ              (SP)+ [TRUE] 64c5
 647b:  0d 6b 00                STORE           G5b,#00
 647e:  6f 63 61 00             LOADW           G53,G51 -> -(SP)
 6482:  41 00 01 40             JE              (SP)+,#01 [FALSE] RFALSE
 6486:  4f 63 01 04             LOADW           G53,#01 -> L03
 648a:  41 04 05 c0             JE              L03,#05 [TRUE] RFALSE
 648e:  b2 ...                  PRINT           "("
 6491:  a0 03 e7                JZ              L02 [TRUE] 64b9
 6494:  e0 2f 32 12 03 03       CALL            6424 (L02) -> L02
 649a:  a7 03                   PRINT_ADDR      L02
 649c:  c1 8f 03 46 9d 45       JE              L02,"out" [FALSE] 64a5
 64a2:  b2 ...                  PRINT           " of"
 64a5:  41 04 01 4f             JE              L03,#01 [FALSE] 64b6
 64a9:  b2 ...                  PRINT           " your hands)"
 64b2:  bb                      NEW_LINE        
 64b3:  8c 00 05                JUMP            64b9
 64b6:  b2 ...                  PRINT           " the "
 64b9:  41 04 01 c8             JE              L03,#01 [TRUE] 64c3
 64bd:  aa 04                   PRINT_OBJ       L03
 64bf:  b2 ...                  PRINT           ")"
 64c2:  bb                      NEW_LINE        
 64c3:  ab 04                   RET             L03
 64c5:  0d 6b 00                STORE           G5b,#00
 64c8:  b1                      RFALSE          

Routine 64ca, 1 local (0000)

 64cd:  4f 74 06 01             LOADW           G64,#06 -> L00
 64d1:  a0 01 e2                JZ              L00 [TRUE] 64f4
 64d4:  50 83 05 6c             LOADB           G73,#05 -> G5c
 64d8:  4f 74 07 00             LOADW           G64,#07 -> -(SP)
 64dc:  e0 2a 32 bd 01 00 66 00 CALL            657a (L00,(SP)+,G56) -> -(SP)
 64e4:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 64e7:  6f 64 61 00             LOADW           G54,G51 -> -(SP)
 64eb:  a0 00 c8                JZ              (SP)+ [TRUE] 64f4
 64ee:  e0 2f 32 96 66 66       CALL            652c (G56) -> G56
 64f4:  4f 74 08 01             LOADW           G64,#08 -> L00
 64f8:  a0 01 c1                JZ              L00 [TRUE] RTRUE
 64fb:  50 83 06 6c             LOADB           G73,#06 -> G5c
 64ff:  4f 74 09 00             LOADW           G64,#09 -> -(SP)
 6503:  e0 2a 32 bd 01 00 65 00 CALL            657a (L00,(SP)+,G55) -> -(SP)
 650b:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 650e:  6f 64 61 00             LOADW           G54,G51 -> -(SP)
 6512:  a0 00 c1                JZ              (SP)+ [TRUE] RTRUE
 6515:  6f 65 61 00             LOADW           G55,G51 -> -(SP)
 6519:  41 00 01 49             JE              (SP)+,#01 [FALSE] 6524
 651d:  e0 2f 32 96 66 66       CALL            652c (G56) -> G56
 6523:  b0                      RTRUE           
 6524:  e0 2f 32 96 65 65       CALL            652c (G55) -> G55
 652a:  b0                      RTRUE           

Routine 652c, 7 locals (0000, 0000, 0000, 0001, 0000, 0000, 0000)

 653b:  6f 01 61 02             LOADW           L00,G51 -> L01
 653f:  e1 a7 63 61 00          STOREW          G53,G51,#00
 6544:  04 02 00 45             DEC_CHK         L01,#00 [FALSE] 654b
 6548:  8c 00 23                JUMP            656c
 654b:  6f 01 04 06             LOADW           L00,L03 -> L05
 654f:  e0 2b 36 11 06 64 00    CALL            6c22 (L05,G54) -> -(SP)
 6556:  a0 00 c5                JZ              (SP)+ [TRUE] 655c
 6559:  8c 00 0d                JUMP            6567
 655c:  54 05 01 00             ADD             L04,#01 -> -(SP)
 6560:  e1 ab 63 00 06          STOREW          G53,(SP)+,L05
 6565:  95 05                   INC             L04
 6567:  95 04                   INC             L03
 6569:  8c ff da                JUMP            6544
 656c:  e1 ab 63 61 05          STOREW          G53,G51,L04
 6571:  2d 07 63                STORE           L06,G53
 6574:  2d 63 01                STORE           G53,L00
 6577:  ab 07                   RET             L06

Routine 657a, 8 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000)

 658b:  0d 60 00                STORE           G50,#00
 658e:  2d 5f 01                STORE           G4f,L00
 6591:  2d 5e 02                STORE           G4e,L01
 6594:  0d 5d 00                STORE           G4d,#00
 6597:  e1 a7 64 61 00          STOREW          G54,G51,#00
 659c:  e1 a7 03 61 00          STOREW          L02,G51,#00
 65a1:  4f 01 00 07             LOADW           L00,#00 -> L06
 65a5:  61 01 02 56             JE              L00,L01 [FALSE] 65bd
 65a9:  a0 04 c8                JZ              L03 [TRUE] 65b2
 65ac:  e8 bf 04                PUSH            L03
 65af:  8c 00 05                JUMP            65b5
 65b2:  e8 bf 03                PUSH            L02
 65b5:  e0 2f 33 61 00 00       CALL            66c2 ((SP)+) -> -(SP)
 65bb:  ab 00                   RET             (SP)+
 65bd:  4f 01 02 08             LOADW           L00,#02 -> L07
 65c1:  c1 8f 07 3b 7c 53       JE              L06,"all" [FALSE] 65d8
 65c7:  0d 60 01                STORE           G50,#01
 65ca:  c1 8f 08 46 50 00 e4    JE              L07,"of" [FALSE] 66b3
 65d1:  54 01 04 01             ADD             L00,#04 -> L00
 65d5:  8c 00 dd                JUMP            66b3
 65d8:  c1 83 07 3d 97 40 61 62 JE              L06,"but","except" [FALSE] 6600
 65e0:  a0 04 c8                JZ              L03 [TRUE] 65e9
 65e3:  e8 bf 04                PUSH            L03
 65e6:  8c 00 05                JUMP            65ec
 65e9:  e8 bf 03                PUSH            L02
 65ec:  e0 2f 33 61 00 00       CALL            66c2 ((SP)+) -> -(SP)
 65f2:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 65f5:  2d 04 64                STORE           L03,G54
 65f8:  e1 a7 04 61 00          STOREW          L03,G51,#00
 65fd:  8c 00 b5                JUMP            66b3
 6600:  c1 83 07 3b 44 46 7a 74 JE              L06,"a","one" [FALSE] 663a
 6608:  a0 69 53                JZ              G59 [FALSE] 661c
 660b:  0d 60 02                STORE           G50,#02
 660e:  c1 8f 08 46 50 00 a0    JE              L07,"of" [FALSE] 66b3
 6615:  54 01 04 01             ADD             L00,#04 -> L00
 6619:  8c 00 99                JUMP            66b3
 661c:  2d 6a 84                STORE           G5a,G74
 661f:  a0 04 c8                JZ              L03 [TRUE] 6628
 6622:  e8 bf 04                PUSH            L03
 6625:  8c 00 05                JUMP            662b
 6628:  e8 bf 03                PUSH            L02
 662b:  e0 2f 33 61 00 00       CALL            66c2 ((SP)+) -> -(SP)
 6631:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 6634:  a0 08 c1                JZ              L07 [TRUE] RTRUE
 6637:  8c 00 7b                JUMP            66b3
 663a:  c1 83 07 3b 98 3b 36 64 JE              L06,"and","," [FALSE] 6664
 6642:  c1 83 08 3b 98 3b 36 dc JE              L07,"and","," [TRUE] 6664
 664a:  0d 5d 01                STORE           G4d,#01
 664d:  a0 04 c8                JZ              L03 [TRUE] 6656
 6650:  e8 bf 04                PUSH            L03
 6653:  8c 00 05                JUMP            6659
 6656:  e8 bf 03                PUSH            L02
 6659:  e0 2f 33 61 00 00       CALL            66c2 ((SP)+) -> -(SP)
 665f:  a0 00 00 52             JZ              (SP)+ [FALSE] 66b3
 6663:  b1                      RFALSE          
 6664:  e0 27 2d d5 07 04 00    CALL            5baa (L06,#04) -> -(SP)
 666b:  a0 00 c5                JZ              (SP)+ [TRUE] 6671
 666e:  8c 00 44                JUMP            66b3
 6671:  c1 83 07 3b 98 3b 36 45 JE              L06,"and","," [FALSE] 667c
 6679:  8c 00 39                JUMP            66b3
 667c:  c1 8f 07 46 50 4b       JE              L06,"of" [FALSE] 668b
 6682:  a0 60 70                JZ              G50 [FALSE] 66b3
 6685:  0d 60 04                STORE           G50,#04
 6688:  8c 00 2a                JUMP            66b3
 668b:  e0 25 2d d5 07 20 02 06 CALL            5baa (L06,#20,#02) -> L05
 6693:  a0 06 ce                JZ              L05 [TRUE] 66a2
 6696:  a0 69 4b                JZ              G59 [FALSE] 66a2
 6699:  2d 69 06                STORE           G59,L05
 669c:  2d 67 07                STORE           G57,L06
 669f:  8c 00 13                JUMP            66b3
 66a2:  e0 25 2d d5 07 80 00 00 CALL            5baa (L06,#80,#00) -> -(SP)
 66aa:  a0 00 c8                JZ              (SP)+ [TRUE] 66b3
 66ad:  2d 6a 07                STORE           G5a,L06
 66b0:  2d 84 07                STORE           G74,L06
 66b3:  61 01 02 be ef          JE              L00,L01 [TRUE] 65a5
 66b8:  54 01 04 01             ADD             L00,#04 -> L00
 66bc:  2d 07 08                STORE           L06,L07
 66bf:  8c fe e5                JUMP            65a5

Routine 66c2, 9 locals (0000, 0001, 0000, 0000, 0000, 0000, 0000, 0000, 0000)

 66d5:  2d 05 6c                STORE           L04,G5c
 66d8:  6f 01 61 06             LOADW           L00,G51 -> L05
 66dc:  47 60 04 c1             TEST            G50,#04 [TRUE] RTRUE
 66e0:  a0 6a 56                JZ              G5a [FALSE] 66f7
 66e3:  a0 69 d3                JZ              G59 [TRUE] 66f7
 66e6:  e0 25 2d d5 67 80 00 00 CALL            5baa (G57,#80,#00) -> -(SP)
 66ee:  a0 00 c8                JZ              (SP)+ [TRUE] 66f7
 66f1:  2d 6a 67                STORE           G5a,G57
 66f4:  0d 69 00                STORE           G59,#00
 66f7:  a0 6a 6c                JZ              G5a [FALSE] 6724
 66fa:  a0 69 69                JZ              G59 [FALSE] 6724
 66fd:  41 60 01 e5             JE              G50,#01 [TRUE] 6724
 6701:  a0 6b 62                JZ              G5b [FALSE] 6724
 6704:  a0 02 c0                JZ              L01 [TRUE] RFALSE
 6707:  b2 ...                  PRINT           "There seems to be a noun missing in that sentence!"
 6722:  bb                      NEW_LINE        
 6723:  b1                      RFALSE          
 6724:  41 60 01 45             JE              G50,#01 [FALSE] 672b
 6728:  a0 6c 47                JZ              G5c [FALSE] 6730
 672b:  cd 4f 6c ff ff          STORE           G5c,#ffff
 6730:  2d 85 01                STORE           G75,L00
 6733:  a0 07 cb                JZ              L06 [TRUE] 673f
 6736:  e0 2f 34 a8 01 00       CALL            6950 (L00) -> -(SP)
 673c:  8c 00 1b                JUMP            6758
 673f:  a0 52 d0                JZ              G42 [TRUE] 6750
 6742:  4c 90 0c                CLEAR_ATTR      G80,#0c
 6745:  e0 25 35 0f 10 10 20 00 CALL            6a1e (G00,#10,#20) -> -(SP)
 674d:  4b 90 0c                SET_ATTR        G80,#0c
 6750:  e0 25 35 0f 90 80 40 00 CALL            6a1e (G80,#80,#40) -> -(SP)
 6758:  6f 01 61 00             LOADW           L00,G51 -> -(SP)
 675c:  75 00 06 04             SUB             (SP)+,L05 -> L03
 6760:  47 60 01 45             TEST            G50,#01 [FALSE] 6767
 6764:  8c 01 0d                JUMP            6872
 6767:  47 60 02 73             TEST            G50,#02 [FALSE] 679c
 676b:  a0 04 f0                JZ              L03 [TRUE] 679c
 676e:  41 04 01 e4             JE              L03,#01 [TRUE] 6794
 6772:  e7 bf 04 00             RANDOM          L03 -> -(SP)
 6776:  6f 01 00 00             LOADW           L00,(SP)+ -> -(SP)
 677a:  e1 9b 01 01 00          STOREW          L00,#01,(SP)+
 677f:  b2 ...                  PRINT           "(How about the "
 6788:  4f 01 01 00             LOADW           L00,#01 -> -(SP)
 678c:  aa 00                   PRINT_OBJ       (SP)+
 678e:  b2 ...                  PRINT           "?)"
 6793:  bb                      NEW_LINE        
 6794:  e1 a7 01 61 01          STOREW          L00,G51,#01
 6799:  8c 00 d8                JUMP            6872
 679c:  43 04 01 cd             JG              L03,#01 [TRUE] 67ab
 67a0:  a0 04 00 8c             JZ              L03 [FALSE] 682e
 67a4:  c1 8f 6c ff ff 80 85    JE              G5c,#ffff [TRUE] 682e
 67ab:  c1 8f 6c ff ff 58       JE              G5c,#ffff [FALSE] 67c7
 67b1:  2d 6c 05                STORE           G5c,L04
 67b4:  2d 08 04                STORE           L07,L03
 67b7:  6f 01 61 00             LOADW           L00,G51 -> -(SP)
 67bb:  75 00 04 00             SUB             (SP)+,L03 -> -(SP)
 67bf:  e1 ab 01 61 00          STOREW          L00,G51,(SP)+
 67c4:  8c ff 6e                JUMP            6733
 67c7:  a0 04 45                JZ              L03 [FALSE] 67cd
 67ca:  2d 04 08                STORE           L03,L07
 67cd:  61 7f 90 c8             JE              G6f,G80 [TRUE] 67d7
 67d1:  e0 3f 31 2b 00          CALL            6256 -> -(SP)
 67d6:  b1                      RFALSE          
 67d7:  a0 02 f0                JZ              L01 [TRUE] 6808
 67da:  a0 6a ed                JZ              G5a [TRUE] 6808
 67dd:  e0 2a 34 6f 06 04 01 00 CALL            68de (L05,L03,L00) -> -(SP)
 67e5:  61 01 66 48             JE              L00,G56 [FALSE] 67ef
 67e9:  e8 7f 06                PUSH            #06
 67ec:  8c 00 05                JUMP            67f2
 67ef:  e8 7f 08                PUSH            #08
 67f2:  2d 77 00                STORE           G67,(SP)+
 67f5:  2d 75 69                STORE           G65,G59
 67f8:  2d 76 6a                STORE           G66,G5a
 67fb:  e0 17 31 3c 00 00 00    CALL            6278 (#00,#00) -> -(SP)
 6802:  0d 79 01                STORE           G69,#01
 6805:  8c 00 21                JUMP            6827
 6808:  a0 02 de                JZ              L01 [TRUE] 6827
 680b:  b2 ...                  PRINT           "There seems to be a noun missing in that sentence!"
 6826:  bb                      NEW_LINE        
 6827:  0d 6a 00                STORE           G5a,#00
 682a:  0d 69 00                STORE           G59,#00
 682d:  b1                      RFALSE          
 682e:  a0 04 7a                JZ              L03 [FALSE] 6869
 6831:  a0 07 f7                JZ              L06 [TRUE] 6869
 6834:  a0 02 ed                JZ              L01 [TRUE] 6862
 6837:  a0 52 dc                JZ              G42 [TRUE] 6854
 683a:  e0 1b 35 5d 0b 01 00    CALL            6aba (#0b,L00) -> -(SP)
 6841:  2d 5b 6a                STORE           G4b,G5a
 6844:  2d 5a 69                STORE           G4a,G59
 6847:  2d 59 67                STORE           G49,G57
 684a:  0d 6a 00                STORE           G5a,#00
 684d:  0d 69 00                STORE           G59,#00
 6850:  0d 67 00                STORE           G57,#00
 6853:  b0                      RTRUE           
 6854:  b2 ...                  PRINT           "It's too dark to see!"
 6861:  bb                      NEW_LINE        
 6862:  0d 6a 00                STORE           G5a,#00
 6865:  0d 69 00                STORE           G59,#00
 6868:  b1                      RFALSE          
 6869:  a0 04 48                JZ              L03 [FALSE] 6872
 686c:  0d 07 01                STORE           L06,#01
 686f:  8c fe c3                JUMP            6733
 6872:  2d 6c 05                STORE           G5c,L04
 6875:  0d 6a 00                STORE           G5a,#00
 6878:  0d 69 00                STORE           G59,#00
 687b:  b0                      RTRUE           

Routine 687c, 3 locals (0000, 0000, 0000)

 6883:  cd 4f 6c ff ff          STORE           G5c,#ffff
 6888:  2d 6a 5b                STORE           G5a,G4b
 688b:  2d 69 5a                STORE           G59,G4a
 688e:  e1 a7 01 61 00          STOREW          L00,G51,#00
 6893:  92 52 02 c2             GET_CHILD       #52 -> L01 [TRUE] 6897
 6897:  a0 02 45                JZ              L01 [FALSE] 689d
 689a:  8c 00 11                JUMP            68ac
 689d:  e0 29 35 29 02 01 01 00 CALL            6a52 (L01,L00,#01) -> -(SP)
 68a5:  a1 02 02 c2             GET_SIBLING     L01 -> L01 [TRUE] 68a9
 68a9:  8c ff ed                JUMP            6897
 68ac:  6f 01 61 03             LOADW           L00,G51 -> L02
 68b0:  a0 03 4a                JZ              L02 [FALSE] 68bb
 68b3:  e0 15 35 0f f9 01 01 00 CALL            6a1e (#f9,#01,#01) -> -(SP)
 68bb:  6f 01 61 03             LOADW           L00,G51 -> L02
 68bf:  a0 03 4a                JZ              L02 [FALSE] 68ca
 68c2:  e0 15 35 0f 52 01 01 00 CALL            6a1e (#52,#01,#01) -> -(SP)
 68ca:  6f 01 61 03             LOADW           L00,G51 -> L02
 68ce:  41 03 01 46             JE              L02,#01 [FALSE] 68d6
 68d2:  4f 01 01 5c             LOADW           L00,#01 -> G4c
 68d6:  0d 6a 00                STORE           G5a,#00
 68d9:  0d 69 00                STORE           G59,#00
 68dc:  ab 03                   RET             L02

Routine 68de, 5 locals (0000, 0000, 0000, 0000, 0000)

 68e9:  2d 05 02                STORE           L04,L01
 68ec:  b2 ...                  PRINT           "Which"
 68f1:  a0 79 48                JZ              G69 [FALSE] 68fa
 68f4:  a0 78 45                JZ              G68 [FALSE] 68fa
 68f7:  a0 5d ca                JZ              G4d [TRUE] 6902
 68fa:  b2 ...                  PRINT           " "
 68fd:  a7 6a                   PRINT_ADDR      G5a
 68ff:  8c 00 19                JUMP            6919
 6902:  61 03 66 4d             JE              L02,G56 [FALSE] 6911
 6906:  e0 15 31 6a 06 07 00 00 CALL            62d4 (#06,#07,#00) -> -(SP)
 690e:  8c 00 0a                JUMP            6919
 6911:  e0 15 31 6a 08 09 00 00 CALL            62d4 (#08,#09,#00) -> -(SP)
 6919:  b2 ...                  PRINT           " do you mean, "
 6922:  95 01                   INC             L00
 6924:  6f 03 01 04             LOADW           L02,L00 -> L03
 6928:  b2 ...                  PRINT           "the "
 692b:  aa 04                   PRINT_OBJ       L03
 692d:  41 02 02 51             JE              L01,#02 [FALSE] 6940
 6931:  41 05 02 c5             JE              L04,#02 [TRUE] 6938
 6935:  b2 ...                  PRINT           ","
 6938:  b2 ...                  PRINT           " or "
 693d:  8c 00 09                JUMP            6947
 6940:  43 02 02 45             JG              L01,#02 [FALSE] 6947
 6944:  b2 ...                  PRINT           ", "
 6947:  04 02 01 3f d8          DEC_CHK         L01,#01 [FALSE] 6922
 694c:  b3 ...                  PRINT_RET       "?"

Routine 6950, 8 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000)

 6961:  6f 01 61 02             LOADW           L00,G51 -> L01
 6965:  2d 07 6c                STORE           L06,G5c
 6968:  52 10 05 03             GET_PROP_ADDR   G00,#05 -> L02
 696c:  a0 03 e3                JZ              L02 [TRUE] 6990
 696f:  a4 03 00                GET_PROP_LEN    L02 -> -(SP)
 6972:  55 00 01 04             SUB             (SP)+,#01 -> L03
 6976:  70 03 05 06             LOADB           L02,L04 -> L05
 697a:  e0 2b 36 8e 06 01 00    CALL            6d1c (L05,L00) -> -(SP)
 6981:  a0 00 c9                JZ              (SP)+ [TRUE] 698b
 6984:  e0 2b 35 5d 06 01 00    CALL            6aba (L05,L00) -> -(SP)
 698b:  25 05 04 3f e8          INC_CHK         L04,L03 [FALSE] 6976
 6990:  52 10 04 03             GET_PROP_ADDR   G00,#04 -> L02
 6994:  a0 03 80 56             JZ              L02 [TRUE] 69ec
 6998:  a4 03 00                GET_PROP_LEN    L02 -> -(SP)
 699b:  57 00 04 00             DIV             (SP)+,#04 -> -(SP)
 699f:  55 00 01 04             SUB             (SP)+,#01 -> L03
 69a3:  0d 05 00                STORE           L04,#00
 69a6:  56 05 02 00             MUL             L04,#02 -> -(SP)
 69aa:  6f 03 00 00             LOADW           L02,(SP)+ -> -(SP)
 69ae:  61 6a 00 77             JE              G5a,(SP)+ [FALSE] 69e7
 69b2:  56 05 02 00             MUL             L04,#02 -> -(SP)
 69b6:  54 00 01 00             ADD             (SP)+,#01 -> -(SP)
 69ba:  6f 03 00 00             LOADW           L02,(SP)+ -> -(SP)
 69be:  e3 5b 0d 11 00          PUT_PROP        "pseudo",#11,(SP)+
 69c3:  12 0d 11 00             GET_PROP_ADDR   "pseudo",#11 -> -(SP)
 69c7:  55 00 05 08             SUB             (SP)+,#05 -> L07
 69cb:  4f 6a 00 00             LOADW           G5a,#00 -> -(SP)
 69cf:  e1 9b 08 00 00          STOREW          L07,#00,(SP)+
 69d4:  4f 6a 01 00             LOADW           G5a,#01 -> -(SP)
 69d8:  e1 9b 08 01 00          STOREW          L07,#01,(SP)+
 69dd:  e0 1b 35 5d 0d 01 00    CALL            6aba (#0d,L00) -> -(SP)
 69e4:  8c 00 07                JUMP            69ec
 69e7:  25 05 04 3f bc          INC_CHK         L04,L03 [FALSE] 69a6
 69ec:  6f 01 61 00             LOADW           L00,G51 -> -(SP)
 69f0:  61 00 02 40             JE              (SP)+,L01 [FALSE] RFALSE
 69f4:  cd 4f 6c ff ff          STORE           G5c,#ffff
 69f9:  2d 85 01                STORE           G75,L00
 69fc:  e0 15 35 0f f7 01 01 00 CALL            6a1e (#f7,#01,#01) -> -(SP)
 6a04:  2d 6c 07                STORE           G5c,L06
 6a07:  6f 01 61 00             LOADW           L00,G51 -> -(SP)
 6a0b:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 6a0e:  c1 95 88 39 71 38 40    JE              G78,#39,#71,#38 [FALSE] RFALSE
 6a15:  e0 15 35 0f 52 01 01 00 CALL            6a1e (#52,#01,#01) -> -(SP)
 6a1d:  b8                      RET_POPPED      

Routine 6a1e, 4 locals (0000, 0000, 0000, 0000)

 6a27:  74 02 03 00             ADD             L01,L02 -> -(SP)
 6a2b:  67 6c 00 4b             TEST            G5c,(SP)+ [FALSE] 6a38
 6a2f:  e0 29 35 29 01 85 01 00 CALL            6a52 (L00,G75,#01) -> -(SP)
 6a37:  b8                      RET_POPPED      
 6a38:  67 6c 02 4b             TEST            G5c,L01 [FALSE] 6a45
 6a3c:  e0 29 35 29 01 85 00 00 CALL            6a52 (L00,G75,#00) -> -(SP)
 6a44:  b8                      RET_POPPED      
 6a45:  67 6c 03 41             TEST            G5c,L02 [FALSE] RTRUE
 6a49:  e0 29 35 29 01 85 02 00 CALL            6a52 (L00,G75,#02) -> -(SP)
 6a51:  b8                      RET_POPPED      

Routine 6a52, 5 locals (0000, 0000, 0000, 0000, 0000)

 6a5d:  a2 01 01 40             GET_CHILD       L00 -> L00 [FALSE] RFALSE
 6a61:  41 03 02 da             JE              L02,#02 [TRUE] 6a7d
 6a65:  52 01 12 00             GET_PROP_ADDR   L00,#12 -> -(SP)
 6a69:  a0 00 d3                JZ              (SP)+ [TRUE] 6a7d
 6a6c:  e0 2b 36 8e 01 02 00    CALL            6d1c (L00,L01) -> -(SP)
 6a73:  a0 00 c9                JZ              (SP)+ [TRUE] 6a7d
 6a76:  e0 2b 35 5d 01 02 00    CALL            6aba (L00,L01) -> -(SP)
 6a7d:  41 03 00 4a             JE              L02,#00 [FALSE] 6a89
 6a81:  4a 01 08 c6             TEST_ATTR       L00,#08 [TRUE] 6a89
 6a85:  4a 01 0a 6d             TEST_ATTR       L00,#0a [FALSE] 6ab4
 6a89:  a2 01 05 69             GET_CHILD       L00 -> L04 [FALSE] 6ab4
 6a8d:  4a 01 0b c6             TEST_ATTR       L00,#0b [TRUE] 6a95
 6a91:  4a 01 0c 61             TEST_ATTR       L00,#0c [FALSE] 6ab4
 6a95:  4a 01 0a 48             TEST_ATTR       L00,#0a [FALSE] 6a9f
 6a99:  e8 7f 01                PUSH            #01
 6a9c:  8c 00 0f                JUMP            6aac
 6a9f:  4a 01 08 48             TEST_ATTR       L00,#08 [FALSE] 6aa9
 6aa3:  e8 7f 01                PUSH            #01
 6aa6:  8c 00 05                JUMP            6aac
 6aa9:  e8 7f 00                PUSH            #00
 6aac:  e0 2a 35 29 01 02 00 04 CALL            6a52 (L00,L01,(SP)+) -> L03
 6ab4:  a1 01 01 bf aa          GET_SIBLING     L00 -> L00 [TRUE] 6a61
 6ab9:  b0                      RTRUE           

Routine 6aba, 3 locals (0000, 0000, 0000)

 6ac1:  6f 02 61 03             LOADW           L01,G51 -> L02
 6ac5:  54 03 01 00             ADD             L02,#01 -> -(SP)
 6ac9:  e1 ab 02 00 01          STOREW          L01,(SP)+,L00
 6ace:  54 03 01 00             ADD             L02,#01 -> -(SP)
 6ad2:  e1 ab 02 61 00          STOREW          L01,G51,(SP)+
 6ad7:  b0                      RTRUE           

Routine 6ad8, 0 locals ()

 6ad9:  50 83 05 00             LOADB           G73,#05 -> -(SP)
 6add:  e0 2b 35 7a 66 00 00    CALL            6af4 (G56,(SP)+) -> -(SP)
 6ae4:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 6ae7:  50 83 06 00             LOADB           G73,#06 -> -(SP)
 6aeb:  e0 2b 35 7a 65 00 00    CALL            6af4 (G55,(SP)+) -> -(SP)
 6af2:  b8                      RET_POPPED      

Routine 6af4, 5 locals (0000, 0000, 0000, 0000, 0000)

 6aff:  6f 01 61 03             LOADW           L00,G51 -> L02
 6b03:  a0 03 c1                JZ              L02 [TRUE] RTRUE
 6b06:  47 02 02 c6             TEST            L01,#02 [TRUE] 6b0e
 6b0a:  47 02 08 41             TEST            L01,#08 [FALSE] RTRUE
 6b0e:  04 03 00 c1             DEC_CHK         L02,#00 [TRUE] RTRUE
 6b12:  54 03 01 00             ADD             L02,#01 -> -(SP)
 6b16:  6f 01 00 04             LOADW           L00,(SP)+ -> L03
 6b1a:  41 04 0c 45             JE              L03,#0c [FALSE] 6b21
 6b1e:  2d 04 7b                STORE           L03,G6b
 6b21:  e0 2f 4a 76 04 00       CALL            94ec (L03) -> -(SP)
 6b27:  a0 00 3f e5             JZ              (SP)+ [FALSE] 6b0e
 6b2b:  41 04 01 bf e0          JE              L03,#01 [TRUE] 6b0e
 6b30:  2d 86 04                STORE           G76,L03
 6b33:  4a 04 0d 48             TEST_ATTR       L03,#0d [FALSE] 6b3d
 6b37:  0d 05 01                STORE           L04,#01
 6b3a:  8c 00 23                JUMP            6b5e
 6b3d:  41 7f 04 c8             JE              G6f,#04 [TRUE] 6b47
 6b41:  0d 05 00                STORE           L04,#00
 6b44:  8c 00 19                JUMP            6b5e
 6b47:  47 02 08 52             TEST            L01,#08 [FALSE] 6b5b
 6b4b:  e0 1f 48 7a 00 00       CALL            90f4 (#00) -> -(SP)
 6b51:  41 00 01 48             JE              (SP)+,#01 [FALSE] 6b5b
 6b55:  0d 05 00                STORE           L04,#00
 6b58:  8c 00 05                JUMP            6b5e
 6b5b:  0d 05 01                STORE           L04,#01
 6b5e:  a0 05 e3                JZ              L04 [TRUE] 6b82
 6b61:  47 02 02 5f             TEST            L01,#02 [FALSE] 6b82
 6b65:  41 04 0b 4d             JE              L03,#0b [FALSE] 6b74
 6b69:  b2 ...                  PRINT           "You don't have that!"
 6b72:  bb                      NEW_LINE        
 6b73:  b1                      RFALSE          
 6b74:  b2 ...                  PRINT           "You don't have the "
 6b7b:  aa 04                   PRINT_OBJ       L03
 6b7d:  b2 ...                  PRINT           "."
 6b80:  bb                      NEW_LINE        
 6b81:  b1                      RFALSE          
 6b82:  a0 05 3f 8a             JZ              L04 [FALSE] 6b0e
 6b86:  41 7f 04 3f 85          JE              G6f,#04 [FALSE] 6b0e
 6b8b:  b2 ...                  PRINT           "(Taken)"
 6b94:  bb                      NEW_LINE        
 6b95:  8c ff 78                JUMP            6b0e

Routine 6b98, 3 locals (0000, 0000, 0000)

 6b9f:  6f 66 61 00             LOADW           G56,G51 -> -(SP)
 6ba3:  43 00 01 50             JG              (SP)+,#01 [FALSE] 6bb5
 6ba7:  50 83 05 00             LOADB           G73,#05 -> -(SP)
 6bab:  47 00 04 c8             TEST            (SP)+,#04 [TRUE] 6bb5
 6baf:  0d 01 01                STORE           L00,#01
 6bb2:  8c 00 15                JUMP            6bc8
 6bb5:  6f 65 61 00             LOADW           G55,G51 -> -(SP)
 6bb9:  43 00 01 4d             JG              (SP)+,#01 [FALSE] 6bc8
 6bbd:  50 83 06 00             LOADB           G73,#06 -> -(SP)
 6bc1:  47 00 04 c5             TEST            (SP)+,#04 [TRUE] 6bc8
 6bc5:  0d 01 02                STORE           L00,#02
 6bc8:  a0 01 c1                JZ              L00 [TRUE] RTRUE
 6bcb:  b2 ...                  PRINT           "You can't use multiple "
 6bd8:  41 01 02 45             JE              L00,#02 [FALSE] 6bdf
 6bdc:  b2 ...                  PRINT           "in"
 6bdf:  b2 ...                  PRINT           "direct objects with ""
 6bee:  4f 74 01 02             LOADW           G64,#01 -> L01
 6bf2:  a0 02 4a                JZ              L01 [FALSE] 6bfd
 6bf5:  b2 ...                  PRINT           "tell"
 6bfa:  8c 00 20                JUMP            6c1b
 6bfd:  a0 79 45                JZ              G69 [FALSE] 6c03
 6c00:  a0 78 cb                JZ              G68 [TRUE] 6c0c
 6c03:  4f 02 00 00             LOADW           L01,#00 -> -(SP)
 6c07:  a7 00                   PRINT_ADDR      (SP)+
 6c09:  8c 00 11                JUMP            6c1b
 6c0c:  50 02 02 03             LOADB           L01,#02 -> L02
 6c10:  50 02 03 00             LOADB           L01,#03 -> -(SP)
 6c14:  e0 2b 2f ed 03 00 00    CALL            5fda (L02,(SP)+) -> -(SP)
 6c1b:  b2 ...                  PRINT           ""."
 6c20:  bb                      NEW_LINE        
 6c21:  b1                      RFALSE          

Routine 6c22, 4 locals (0000, 0000, ffff, 0001)

 6c2b:  a0 02 c0                JZ              L01 [TRUE] RFALSE
 6c2e:  42 03 00 c8             JL              L02,#00 [TRUE] 6c38
 6c32:  0d 04 00                STORE           L03,#00
 6c35:  8c 00 06                JUMP            6c3c
 6c38:  4f 02 00 03             LOADW           L01,#00 -> L02
 6c3c:  6f 02 04 00             LOADW           L01,L03 -> -(SP)
 6c40:  61 01 00 c1             JE              L00,(SP)+ [TRUE] RTRUE
 6c44:  25 04 03 3f f5          INC_CHK         L03,L02 [FALSE] 6c3c
 6c49:  b1                      RFALSE          

Routine 6c4a, 4 locals (0000, 0000, 0000, 0000)

 6c53:  70 02 04 00             LOADB           L01,L03 -> -(SP)
 6c57:  61 01 00 c1             JE              L00,(SP)+ [TRUE] RTRUE
 6c5b:  25 04 03 3f f5          INC_CHK         L03,L02 [FALSE] 6c53
 6c60:  b1                      RFALSE          

Routine 6c62, 4 locals (0000, 0001, 0000, 0000)

 6c6b:  a0 58 c6                JZ              G48 [TRUE] 6c72
 6c6e:  61 7f 90 c1             JE              G6f,G80 [TRUE] RTRUE
 6c72:  0d 6b 14                STORE           G5b,#14
 6c75:  2d 03 10                STORE           L02,G00
 6c78:  2d 10 01                STORE           G00,L00
 6c7b:  a0 02 cc                JZ              L01 [TRUE] 6c88
 6c7e:  4a 01 14 48             TEST_ATTR       L00,#14 [FALSE] 6c88
 6c82:  0d 04 01                STORE           L03,#01
 6c85:  8c 00 3e                JUMP            6cc4
 6c88:  e1 a7 63 61 00          STOREW          G53,G51,#00
 6c8d:  2d 85 63                STORE           G75,G53
 6c90:  cd 4f 6c ff ff          STORE           G5c,#ffff
 6c95:  61 03 01 5a             JE              L02,L00 [FALSE] 6cb1
 6c99:  e0 25 35 0f 7f 01 01 00 CALL            6a1e (G6f,#01,#01) -> -(SP)
 6ca1:  61 7f 90 ce             JE              G6f,G80 [TRUE] 6cb1
 6ca5:  66 90 01 4a             JIN             G80,L00 [FALSE] 6cb1
 6ca9:  e0 25 35 0f 90 01 01 00 CALL            6a1e (G80,#01,#01) -> -(SP)
 6cb1:  e0 25 35 0f 01 01 01 00 CALL            6a1e (L00,#01,#01) -> -(SP)
 6cb9:  6f 85 61 00             LOADW           G75,G51 -> -(SP)
 6cbd:  43 00 00 45             JG              (SP)+,#00 [FALSE] 6cc4
 6cc1:  0d 04 01                STORE           L03,#01
 6cc4:  2d 10 03                STORE           G00,L02
 6cc7:  0d 6b 00                STORE           G5b,#00
 6cca:  ab 04                   RET             L03

Routine 6ccc, 1 local (0000)

 6ccf:  a0 78 50                JZ              G68 [FALSE] 6ce0
 6cd2:  4f 74 06 01             LOADW           G64,#06 -> L00
 6cd6:  4f 01 00 00             LOADW           L00,#00 -> -(SP)
 6cda:  c1 8f 00 43 cc 48       JE              (SP)+,"it" [FALSE] 6ce6
 6ce0:  b2 ...                  PRINT           " "
 6ce3:  aa 86                   PRINT_OBJ       G76
 6ce5:  b0                      RTRUE           
 6ce6:  4f 74 07 00             LOADW           G64,#07 -> -(SP)
 6cea:  e0 29 31 77 01 00 00 00 CALL            62ee (L00,(SP)+,#00) -> -(SP)
 6cf2:  b8                      RET_POPPED      

Routine 6cf4, 1 local (0000)

 6cf7:  a0 78 50                JZ              G68 [FALSE] 6d08
 6cfa:  4f 74 08 01             LOADW           G64,#08 -> L00
 6cfe:  4f 01 00 00             LOADW           L00,#00 -> -(SP)
 6d02:  c1 8f 00 43 cc 48       JE              (SP)+,"it" [FALSE] 6d0e
 6d08:  b2 ...                  PRINT           " "
 6d0b:  aa 86                   PRINT_OBJ       G76
 6d0d:  b0                      RTRUE           
 6d0e:  4f 74 09 00             LOADW           G64,#09 -> -(SP)
 6d12:  e0 29 31 77 01 00 00 00 CALL            62ee (L00,(SP)+,#00) -> -(SP)
 6d1a:  b8                      RET_POPPED      

Routine 6d1c, 4 locals (0000, 0000, 0000, 0000)

 6d25:  4a 01 07 c0             TEST_ATTR       L00,#07 [TRUE] RFALSE
 6d29:  a0 6a dc                JZ              G5a [TRUE] 6d46
 6d2c:  52 01 12 03             GET_PROP_ADDR   L00,#12 -> L02
 6d30:  a4 03 00                GET_PROP_LEN    L02 -> -(SP)
 6d33:  57 00 02 00             DIV             (SP)+,#02 -> -(SP)
 6d37:  55 00 01 00             SUB             (SP)+,#01 -> -(SP)
 6d3b:  e0 2a 36 11 6a 03 00 00 CALL            6c22 (G5a,L02,(SP)+) -> -(SP)
 6d43:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 6d46:  a0 69 db                JZ              G59 [TRUE] 6d62
 6d49:  52 01 10 03             GET_PROP_ADDR   L00,#10 -> L02
 6d4d:  a0 03 c0                JZ              L02 [TRUE] RFALSE
 6d50:  a4 03 00                GET_PROP_LEN    L02 -> -(SP)
 6d53:  55 00 01 00             SUB             (SP)+,#01 -> -(SP)
 6d57:  e0 2a 36 25 69 03 00 00 CALL            6c4a (G59,L02,(SP)+) -> -(SP)
 6d5f:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 6d62:  a0 6b c1                JZ              G5b [TRUE] RTRUE
 6d65:  6a 01 6b c1             TEST_ATTR       L00,G5b [TRUE] RTRUE
 6d69:  b1                      RFALSE          

Routine 6d6a, 0 locals ()
    Action routine for:
        "verbos"

 6d6b:  0d 57 01                STORE           G47,#01
 6d6e:  0d 56 00                STORE           G46,#00
 6d71:  b3 ...                  PRINT_RET       "Maximum verbosity."

Routine 6d80, 0 locals ()
    Action routine for:
        "brief"

 6d81:  0d 57 00                STORE           G47,#00
 6d84:  0d 56 00                STORE           G46,#00
 6d87:  b3 ...                  PRINT_RET       "Brief descriptions."

Routine 6d96, 0 locals ()
    Action routine for:
        "super"

 6d97:  0d 56 01                STORE           G46,#01
 6d9a:  b3 ...                  PRINT_RET       "Super-brief descriptions."

Routine 6db0, 0 locals ()
    Action routine for:
        "i"

 6db1:  a2 7f 00 49             GET_CHILD       G6f -> -(SP) [FALSE] 6dbc
 6db5:  e0 2f 47 55 7f 00       CALL            8eaa (G6f) -> -(SP)
 6dbb:  b8                      RET_POPPED      
 6dbc:  b3 ...                  PRINT_RET       "You are empty-handed."

Routine 6dcc, 2 locals (0001, 0000)
    Action routine for:
        "q"

 6dd1:  e0 3f 82 c1 00          CALL            10582 -> -(SP)
 6dd6:  a0 01 ed                JZ              L00 [TRUE] 6e04
 6dd9:  b2 ...                  PRINT           "Do you wish to leave the game? (Y is affirmative): "
 6dfc:  e0 3f 48 6e 00          CALL            90dc -> -(SP)
 6e01:  a0 00 45                JZ              (SP)+ [FALSE] 6e07
 6e04:  a0 01 44                JZ              L00 [FALSE] 6e09
 6e07:  ba                      QUIT            
 6e08:  b0                      RTRUE           
 6e09:  b3 ...                  PRINT_RET       "Ok."

Routine 6e0e, 0 locals ()
    Action routine for:
        "restar"

 6e0f:  e0 1f 82 c1 01 00       CALL            10582 (#01) -> -(SP)
 6e15:  b2 ...                  PRINT           "Do you wish to restart? (Y is affirmative): "
 6e36:  e0 3f 48 6e 00          CALL            90dc -> -(SP)
 6e3b:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 6e3e:  b2 ...                  PRINT           "Restarting."
 6e49:  bb                      NEW_LINE        
 6e4a:  b7                      RESTART         
 6e4b:  b3 ...                  PRINT_RET       "Failed."

Routine 6e52, 0 locals ()
    Action routine for:
        "restor"

 6e53:  b6 4e                   RESTORE         [FALSE] 6e61
 6e55:  b2 ...                  PRINT           "Ok."
 6e5a:  bb                      NEW_LINE        
 6e5b:  e0 3f 46 44 00          CALL            8c88 -> -(SP)
 6e60:  b8                      RET_POPPED      
 6e61:  b3 ...                  PRINT_RET       "Failed."

Routine 6e68, 0 locals ()
    Action routine for:
        "save"

 6e69:  b5 47                   SAVE            [FALSE] 6e70
 6e6b:  b3 ...                  PRINT_RET       "Ok."
 6e70:  b3 ...                  PRINT_RET       "Failed."

Routine 6e78, 0 locals ()
    Action routine for:
        "script"

 6e79:  0f 00 08 00             LOADW           #00,#08 -> -(SP)
 6e7d:  48 00 01 00             OR              (SP)+,#01 -> -(SP)
 6e81:  e1 5b 00 08 00          STOREW          #00,#08,(SP)+
 6e86:  b2 ...                  PRINT           "Here begins a transcript of interaction with"
 6ea5:  bb                      NEW_LINE        
 6ea6:  e0 3f 37 70 00          CALL            6ee0 -> -(SP)
 6eab:  b0                      RTRUE           

Routine 6eac, 0 locals ()
    Action routine for:
        "unscri"

 6ead:  b2 ...                  PRINT           "Here ends a transcript of interaction with"
 6eca:  bb                      NEW_LINE        
 6ecb:  e0 3f 37 70 00          CALL            6ee0 -> -(SP)
 6ed0:  0f 00 08 00             LOADW           #00,#08 -> -(SP)
 6ed4:  c9 8f 00 ff fe 00       AND             (SP)+,#fffe -> -(SP)
 6eda:  e1 5b 00 08 00          STOREW          #00,#08,(SP)+
 6edf:  b0                      RTRUE           

Routine 6ee0, 1 local (0011)
    Action routine for:
        "versio"

 6ee3:  b2 ...                  PRINT           "ZORK I: The Great Underground Empire
Copyright (c) 1981, 1982, 1983 Infocom, Inc. "
 6f28:  b2 ...                  PRINT           "All rights reserved."
 6f39:  bb                      NEW_LINE        
 6f3a:  10 00 01 00             LOADB           #00,#01 -> -(SP)
 6f3e:  49 00 08 00             AND             (SP)+,#08 -> -(SP)
 6f42:  a0 00 da                JZ              (SP)+ [TRUE] 6f5d
 6f45:  b2 ...                  PRINT           "Licensed to Tandy Corporation."
 6f5c:  bb                      NEW_LINE        
 6f5d:  b2 ...                  PRINT           "ZORK is a registered trademark of Infocom, Inc.
Revision "
 6f88:  0f 00 01 00             LOADW           #00,#01 -> -(SP)
 6f8c:  c9 8f 00 07 ff 00       AND             (SP)+,#07ff -> -(SP)
 6f92:  e6 bf 00                PRINT_NUM       (SP)+
 6f95:  b2 ...                  PRINT           " / Serial number "
 6fa4:  05 01 17 45             INC_CHK         L00,#17 [FALSE] 6fab
 6fa8:  8c 00 0c                JUMP            6fb5
 6fab:  30 00 01 00             LOADB           #00,L00 -> -(SP)
 6faf:  e5 bf 00                PRINT_CHAR      (SP)+
 6fb2:  8c ff f1                JUMP            6fa4
 6fb5:  bb                      NEW_LINE        
 6fb6:  b0                      RTRUE           

Routine 6fb8, 0 locals ()
    Action routine for:
        "$ve"

 6fb9:  b2 ...                  PRINT           "Verifying disk..."
 6fc8:  bb                      NEW_LINE        
 6fc9:  bd 4f                   VERIFY          [FALSE] 6fd8
 6fcb:  b3 ...                  PRINT_RET       "The disk is correct."
 6fd8:  bb                      NEW_LINE        
 6fd9:  b3 ...                  PRINT_RET       "** Disk Failure **"

Routine 6ff0, 0 locals ()
    Action routine for:
        "plugh"

 6ff1:  b3 ...                  PRINT_RET       "A hollow voice says "Fool.""

Routine 7008, 1 local (0000)
    Action routine for:
        "again"

 700b:  41 8e 89 4a             JE              G7e,#89 [FALSE] 7017
 700f:  e0 2b 2b be 8e 8d 00    CALL            577c (G7e,G7d) -> -(SP)
 7016:  b8                      RET_POPPED      
 7017:  a0 8d cf                JZ              G7d [TRUE] 7027
 701a:  a3 8d 00                GET_PARENT      G7d -> -(SP)
 701d:  a0 00 c6                JZ              (SP)+ [TRUE] 7024
 7020:  4a 8d 07 45             TEST_ATTR       G7d,#07 [FALSE] 7027
 7024:  2d 01 8d                STORE           L00,G7d
 7027:  a0 8c cf                JZ              G7c [TRUE] 7037
 702a:  a3 8c 00                GET_PARENT      G7c -> -(SP)
 702d:  a0 00 c6                JZ              (SP)+ [TRUE] 7034
 7030:  4a 8c 07 45             TEST_ATTR       G7c,#07 [FALSE] 7037
 7034:  2d 01 8c                STORE           L00,G7c
 7037:  a0 01 df                JZ              L00 [TRUE] 7057
 703a:  c1 97 01 0d 52 d9       JE              L00,#0d,#52 [TRUE] 7057
 7040:  b2 ...                  PRINT           "You can't see the "
 7049:  aa 01                   PRINT_OBJ       L00
 704b:  b2 ...                  PRINT           " anymore."
 7054:  bb                      NEW_LINE        
 7055:  9b 02                   RET             #02
 7057:  e0 2a 2b be 8e 8d 8c 00 CALL            577c (G7e,G7d,G7c) -> -(SP)
 705f:  b8                      RET_POPPED      

Routine 7060, 0 locals ()
    Action routine for:
        "awake up OBJ"
"awake OBJ"

 7061:  4a 86 1e 00 47          TEST_ATTR       G76,#1e [FALSE] 70ab
 7066:  51 86 07 00             GET_PROP        G76,#07 -> -(SP)
 706a:  42 00 00 5e             JL              (SP)+,#00 [FALSE] 708a
 706e:  b2 ...                  PRINT           "The "
 7071:  aa 86                   PRINT_OBJ       G76
 7073:  b2 ...                  PRINT           " is rudely awakened."
 7082:  bb                      NEW_LINE        
 7083:  e0 2f 80 6c 86 00       CALL            100d8 (G76) -> -(SP)
 7089:  b8                      RET_POPPED      
 708a:  b3 ...                  PRINT_RET       "He's wide awake, or haven't you noticed..."
 70ab:  b2 ...                  PRINT           "The "
 70ae:  aa 86                   PRINT_OBJ       G76
 70b0:  b3 ...                  PRINT_RET       " isn't sleeping."

Routine 70be, 0 locals ()
    Action routine for:
        "answer"

 70bf:  b2 ...                  PRINT           "Nobody seems to be awaiting your answer."
 70d6:  bb                      NEW_LINE        
 70d7:  0d 7c 00                STORE           G6c,#00
 70da:  0d 70 00                STORE           G60,#00
 70dd:  b0                      RTRUE           

Routine 70de, 0 locals ()
    Action routine for:
        "strike OBJ with OBJ"
"knock down OBJ"
"stab OBJ with OBJ"
"dispat OBJ with OBJ"
"attack OBJ with OBJ"

 70df:  4a 86 1e e4             TEST_ATTR       G76,#1e [TRUE] 7105
 70e3:  b2 ...                  PRINT           "I've known strange people, but fighting a "
 7100:  aa 86                   PRINT_OBJ       G76
 7102:  b3 ...                  PRINT_RET       "?"
 7105:  a0 87 c6                JZ              G77 [TRUE] 710c
 7108:  41 87 01 66             JE              G77,#01 [FALSE] 7130
 710c:  b2 ...                  PRINT           "Trying to attack a "
 711b:  aa 86                   PRINT_OBJ       G76
 711d:  b3 ...                  PRINT_RET       " with your bare hands is suicidal."
 7130:  66 87 7f da             JIN             G77,G6f [TRUE] 714c
 7134:  b2 ...                  PRINT           "You aren't even holding the "
 7147:  aa 87                   PRINT_OBJ       G77
 7149:  b3 ...                  PRINT_RET       "."
 714c:  4a 87 1d e5             TEST_ATTR       G77,#1d [TRUE] 7173
 7150:  b2 ...                  PRINT           "Trying to attack the "
 715f:  aa 86                   PRINT_OBJ       G76
 7161:  b2 ...                  PRINT           " with a "
 7166:  aa 87                   PRINT_OBJ       G77
 7168:  b3 ...                  PRINT_RET       " is suicidal."
 7173:  e0 3f 7e 4e 00          CALL            fc9c -> -(SP)
 7178:  b8                      RET_POPPED      

Routine 717a, 0 locals ()
    Action routine for:
        "back"

 717b:  b3 ...                  PRINT_RET       "Sorry, my memory is poor. Please give a direction."

Routine 71a0, 0 locals ()
    Action routine for:
        "blow up OBJ"
"blast"

 71a1:  b3 ...                  PRINT_RET       "You can't blast anything by using words."

Routine 71ba, 1 local (0000)
    Pre-action routine for:
        "carry in OBJ"
"climb in OBJ"
"board OBJ"

 71bd:  a3 7f 01                GET_PARENT      G6f -> L00
 71c0:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 71c5:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 71c8:  4a 86 1b 76             TEST_ATTR       G76,#1b [FALSE] 7200
 71cc:  66 86 10 dd             JIN             G76,G00 [TRUE] 71eb
 71d0:  b2 ...                  PRINT           "The "
 71d3:  aa 86                   PRINT_OBJ       G76
 71d5:  b2 ...                  PRINT           " must be on the ground to be boarded."
 71e8:  bb                      NEW_LINE        
 71e9:  9b 02                   RET             #02
 71eb:  4a 01 1b 40             TEST_ATTR       L00,#1b [FALSE] RFALSE
 71ef:  b2 ...                  PRINT           "You are already in the "
 71f8:  aa 01                   PRINT_OBJ       L00
 71fa:  b2 ...                  PRINT           "!"
 71fd:  bb                      NEW_LINE        
 71fe:  9b 02                   RET             #02
 7200:  b2 ...                  PRINT           "You have a theory on how to board a "
 7215:  aa 86                   PRINT_OBJ       G76
 7217:  b2 ...                  PRINT           ", perhaps?"
 7220:  bb                      NEW_LINE        
 7221:  9b 02                   RET             #02

Routine 7224, 1 local (0000)
    Action routine for:
        "carry in OBJ"
"climb in OBJ"
"board OBJ"

 7227:  b2 ...                  PRINT           "You are now in the "
 7230:  aa 86                   PRINT_OBJ       G76
 7232:  b2 ...                  PRINT           "."
 7235:  bb                      NEW_LINE        
 7236:  6e 7f 86                INSERT_OBJ      G6f,G76
 7239:  51 86 11 00             GET_PROP        G76,#11 -> -(SP)
 723d:  e0 9f 00 02 00          CALL            (SP)+ (#02) -> -(SP)
 7242:  b0                      RTRUE           

Routine 7244, 0 locals ()
    Action routine for:
        "blow in OBJ"

 7245:  e0 19 2b be 17 86 06 00 CALL            577c (#17,G76,#06) -> -(SP)
 724d:  b8                      RET_POPPED      

Routine 724e, 0 locals ()
    Action routine for:
        "brush OBJ with OBJ"
"brush OBJ"

 724f:  b3 ...                  PRINT_RET       "If you wish, but heaven only knows why."

Routine 726a, 0 locals ()
    Action routine for:
        "bug"

 726b:  b3 ...                  PRINT_RET       "Bug? Not in a flawless program like this! (Cough, cough)."

Routine 7298, 0 locals ()
    Pre-action routine for:
        "light OBJ with OBJ"
"burn down OBJ with OBJ"
"burn OBJ with OBJ"

 7299:  4a 87 19 46             TEST_ATTR       G77,#19 [FALSE] 72a1
 729d:  4a 87 14 c0             TEST_ATTR       G77,#14 [TRUE] RFALSE
 72a1:  b2 ...                  PRINT           "With a "
 72a8:  aa 87                   PRINT_OBJ       G77
 72aa:  b3 ...                  PRINT_RET       "??!?"

Routine 72b2, 0 locals ()
    Action routine for:
        "light OBJ with OBJ"
"burn down OBJ with OBJ"
"burn OBJ with OBJ"

 72b3:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 72b8:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 72bb:  4a 86 1a 00 61          TEST_ATTR       G76,#1a [FALSE] 731f
 72c0:  66 86 7f c6             JIN             G76,G6f [TRUE] 72c8
 72c4:  66 7f 86 79             JIN             G6f,G76 [FALSE] 72ff
 72c8:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 72ce:  b2 ...                  PRINT           "The "
 72d1:  aa 86                   PRINT_OBJ       G76
 72d3:  b2 ...                  PRINT           " catches fire. Unfortunately, you were "
 72e6:  66 7f 86 48             JIN             G6f,G76 [FALSE] 72f0
 72ea:  b2 ...                  PRINT           "in"
 72ed:  8c 00 09                JUMP            72f7
 72f0:  b2 ...                  PRINT           "holding"
 72f7:  e0 0f 83 33 9a 47 00    CALL            10666 (S165) -> -(SP)
 72fe:  b8                      RET_POPPED      
 72ff:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 7305:  b2 ...                  PRINT           "The "
 7308:  aa 86                   PRINT_OBJ       G76
 730a:  b3 ...                  PRINT_RET       " catches fire and is consumed."
 731f:  b2 ...                  PRINT           "You can't burn a "
 7328:  aa 86                   PRINT_OBJ       G76
 732a:  b3 ...                  PRINT_RET       "."

Routine 732e, 0 locals ()
    Action routine for:
        "barf"

 732f:  b3 ...                  PRINT_RET       "Preposterous!"

Routine 733a, 0 locals ()
    Action routine for:
        "go down OBJ"
"climb down OBJ"
"climb"

 733b:  e0 1b 39 b7 16 86 00    CALL            736e (#16,G76) -> -(SP)
 7342:  b8                      RET_POPPED      

Routine 7344, 0 locals ()
    Action routine for:
        "climb OBJ"

 7345:  e0 1b 39 b7 17 86 00    CALL            736e (#17,G76) -> -(SP)
 734c:  b8                      RET_POPPED      

Routine 734e, 0 locals ()
    Action routine for:
        "carry on OBJ"
"climb on OBJ"

 734f:  4a 86 1b 4a             TEST_ATTR       G76,#1b [FALSE] 735b
 7353:  e0 1b 2b be 19 86 00    CALL            577c (#19,G76) -> -(SP)
 735a:  b0                      RTRUE           
 735b:  b2 ...                  PRINT           "You can't climb onto the "
 7368:  aa 86                   PRINT_OBJ       G76
 736a:  b3 ...                  PRINT_RET       "."

Routine 736e, 5 locals (0017, 0000, 0000, 0000, 0000)
    Action routine for:
        "go up OBJ"
"climb up OBJ"
"climb"

 7379:  a0 02 48                JZ              L01 [FALSE] 7382
 737c:  a0 86 c5                JZ              G76 [TRUE] 7382
 737f:  2d 02 86                STORE           L01,G76
 7382:  72 10 01 04             GET_PROP_ADDR   G00,L00 -> L03
 7386:  a0 04 80 56             JZ              L03 [TRUE] 73de
 738a:  a0 02 80 4b             JZ              L01 [TRUE] 73d7
 738e:  a4 04 03                GET_PROP_LEN    L03 -> L02
 7391:  41 03 02 d8             JE              L02,#02 [TRUE] 73ab
 7395:  c1 95 03 04 05 01 00 3c JE              L02,#04,#05,#01 [FALSE] 73d7
 739d:  50 04 00 00             LOADB           L03,#00 -> -(SP)
 73a1:  e0 2b 4a 50 86 00 00    CALL            94a0 (G76,(SP)+) -> -(SP)
 73a8:  a0 00 6e                JZ              (SP)+ [FALSE] 73d7
 73ab:  b2 ...                  PRINT           "The "
 73ae:  aa 02                   PRINT_OBJ       L01
 73b0:  b2 ...                  PRINT           " do"
 73b3:  41 02 49 c5             JE              L01,#49 [TRUE] 73ba
 73b7:  b2 ...                  PRINT           "es"
 73ba:  b2 ...                  PRINT           "n't lead "
 73c3:  41 01 17 48             JE              L00,#17 [FALSE] 73cd
 73c7:  b2 ...                  PRINT           "up"
 73ca:  8c 00 07                JUMP            73d2
 73cd:  b2 ...                  PRINT           "down"
 73d2:  b3 ...                  PRINT_RET       "ward."
 73d7:  e0 2f 4a 38 01 00       CALL            9470 (L00) -> -(SP)
 73dd:  b0                      RTRUE           
 73de:  a0 02 4d                JZ              L01 [FALSE] 73ec
 73e1:  b3 ...                  PRINT_RET       "You can't go that way."
 73ec:  a0 02 ec                JZ              L01 [TRUE] 7419
 73ef:  52 86 12 03             GET_PROP_ADDR   G76,#12 -> L02
 73f3:  a4 03 00                GET_PROP_LEN    L02 -> -(SP)
 73f6:  e0 0a 36 11 4d 65 03 00 00 
                               CALL            6c22 ("wall",L02,(SP)+) -> -(SP)
 73ff:  a0 00 d9                JZ              (SP)+ [TRUE] 7419
 7402:  b3 ...                  PRINT_RET       "Climbing the walls is to no avail."
 7419:  b3 ...                  PRINT_RET       "You can't do that!"

Routine 7422, 0 locals ()
    Action routine for:
        "close OBJ"

 7423:  4a 86 13 e2             TEST_ATTR       G76,#13 [TRUE] 7447
 7427:  4a 86 17 de             TEST_ATTR       G76,#17 [TRUE] 7447
 742b:  b2 ...                  PRINT           "You must tell me how to do that to a "
 7442:  aa 86                   PRINT_OBJ       G76
 7444:  b3 ...                  PRINT_RET       "."
 7447:  4a 86 0a fc             TEST_ATTR       G76,#0a [TRUE] 7485
 744b:  51 86 0a 00             GET_PROP        G76,#0a -> -(SP)
 744f:  a0 00 f5                JZ              (SP)+ [TRUE] 7485
 7452:  4a 86 0b 68             TEST_ATTR       G76,#0b [FALSE] 747c
 7456:  4c 86 0b                CLEAR_ATTR      G76,#0b
 7459:  b2 ...                  PRINT           "Closed."
 7460:  bb                      NEW_LINE        
 7461:  a0 52 c1                JZ              G42 [TRUE] RTRUE
 7464:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 746a:  a0 52 41                JZ              G42 [FALSE] RTRUE
 746d:  b3 ...                  PRINT_RET       "It is now pitch black."
 747c:  b3 ...                  PRINT_RET       "It is already closed."
 7485:  4a 86 17 60             TEST_ATTR       G76,#17 [FALSE] 74a7
 7489:  4a 86 0b 53             TEST_ATTR       G76,#0b [FALSE] 749e
 748d:  4c 86 0b                CLEAR_ATTR      G76,#0b
 7490:  b2 ...                  PRINT           "The "
 7493:  aa 86                   PRINT_OBJ       G76
 7495:  b3 ...                  PRINT_RET       " is now closed."
 749e:  b3 ...                  PRINT_RET       "It is already closed."
 74a7:  b3 ...                  PRINT_RET       "You cannot close that."

Routine 74b2, 0 locals ()
    Action routine for:
        "comman OBJ"

 74b3:  4a 86 1e 56             TEST_ATTR       G76,#1e [FALSE] 74cb
 74b7:  b2 ...                  PRINT           "The "
 74ba:  aa 86                   PRINT_OBJ       G76
 74bc:  b3 ...                  PRINT_RET       " pays no attention."
 74cb:  b3 ...                  PRINT_RET       "You cannot talk to that!"

Routine 74d6, 0 locals ()
    Action routine for:
        "count OBJ"

 74d7:  41 86 0a 5d             JE              G76,#0a [FALSE] 74f6
 74db:  b3 ...                  PRINT_RET       "Well, for one, you are playing Zork..."
 74f6:  b3 ...                  PRINT_RET       "You have lost your mind."

Routine 7504, 0 locals ()
    Action routine for:
        "cross OBJ"

 7505:  b3 ...                  PRINT_RET       "You can't cross that!"

Routine 7510, 0 locals ()
    Action routine for:
        "curse OBJ"
"curse"

 7511:  a0 86 e8                JZ              G76 [TRUE] 753a
 7514:  4a 86 1e 59             TEST_ATTR       G76,#1e [FALSE] 752f
 7518:  b3 ...                  PRINT_RET       "Insults of this nature won't help you."
 752f:  b3 ...                  PRINT_RET       "What a loony!"
 753a:  b3 ...                  PRINT_RET       "Such language in a high-class establishment like this!"

Routine 7562, 0 locals ()
    Action routine for:
        "cut OBJ with OBJ"

 7563:  4a 86 1e 4b             TEST_ATTR       G76,#1e [FALSE] 7570
 7567:  e0 1a 2b be 13 86 87 00 CALL            577c (#13,G76,G77) -> -(SP)
 756f:  b8                      RET_POPPED      
 7570:  4a 86 1a 00 67          TEST_ATTR       G76,#1a [FALSE] 75da
 7575:  4a 87 1d 00 62          TEST_ATTR       G77,#1d [FALSE] 75da
 757a:  66 7f 86 65             JIN             G6f,G76 [FALSE] 75a1
 757e:  b3 ...                  PRINT_RET       "Not a bright idea, especially since you're in it."
 75a1:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 75a7:  b2 ...                  PRINT           "Your skillful "
 75b0:  aa 87                   PRINT_OBJ       G77
 75b2:  b2 ...                  PRINT           "smanship slices the "
 75bf:  aa 86                   PRINT_OBJ       G76
 75c1:  b3 ...                  PRINT_RET       " into innumerable slivers which blow away."
 75da:  4a 87 1d e4             TEST_ATTR       G77,#1d [TRUE] 7600
 75de:  b2 ...                  PRINT           "The "cutting edge" of a "
 75ef:  aa 87                   PRINT_OBJ       G77
 75f1:  b3 ...                  PRINT_RET       " is hardly adequate."
 7600:  b2 ...                  PRINT           "Strange concept, cutting the "
 7615:  aa 86                   PRINT_OBJ       G76
 7617:  b3 ...                  PRINT_RET       "...."

Routine 761e, 0 locals ()
    Action routine for:
        "deflat OBJ"

 761f:  b3 ...                  PRINT_RET       "Come on, now!"

Routine 762a, 0 locals ()
    Action routine for:
        "dig OBJ with OBJ"
"dig in OBJ with OBJ"

 762b:  a0 87 45                JZ              G77 [FALSE] 7631
 762e:  0d 87 01                STORE           G77,#01
 7631:  41 87 79 59             JE              G77,#79 [FALSE] 764c
 7635:  b3 ...                  PRINT_RET       "There's no reason to be digging here."
 764c:  4a 87 1c 5e             TEST_ATTR       G77,#1c [FALSE] 766c
 7650:  b2 ...                  PRINT           "Digging with the "
 765b:  aa 87                   PRINT_OBJ       G77
 765d:  b3 ...                  PRINT_RET       " is slow and tedious."
 766c:  b2 ...                  PRINT           "Digging with a "
 7677:  aa 87                   PRINT_OBJ       G77
 7679:  b3 ...                  PRINT_RET       " is silly."

Routine 7682, 0 locals ()
    Action routine for:
        "carry out OBJ"
"disemb OBJ"

 7683:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 7686:  61 00 86 ce             JE              (SP)+,G76 [TRUE] 7696
 768a:  b2 ...                  PRINT           "You're not in that!"
 7693:  bb                      NEW_LINE        
 7694:  9b 02                   RET             #02
 7696:  4a 10 06 58             TEST_ATTR       G00,#06 [FALSE] 76b0
 769a:  b2 ...                  PRINT           "You are on your own feet again."
 76ab:  bb                      NEW_LINE        
 76ac:  6e 7f 10                INSERT_OBJ      G6f,G00
 76af:  b0                      RTRUE           
 76b0:  b2 ...                  PRINT           "You realize that getting out here would be fatal."
 76cb:  bb                      NEW_LINE        
 76cc:  9b 02                   RET             #02

Routine 76ce, 0 locals ()
    Action routine for:
        "disenc OBJ"

 76cf:  b3 ...                  PRINT_RET       "Nothing happens."

Routine 76dc, 0 locals ()
    Action routine for:
        "drink OBJ"

 76dd:  e0 3f 3b 89 00          CALL            7712 -> -(SP)
 76e2:  b8                      RET_POPPED      

Routine 76e4, 0 locals ()
    Action routine for:
        "drink from OBJ"

 76e5:  b3 ...                  PRINT_RET       "How peculiar!"

Routine 76f0, 0 locals ()
    Pre-action routine for:
        "hide down OBJ"
"pour OBJ from OBJ"
"pour OBJ in OBJ"
"pour OBJ"
"leave OBJ"
"drop OBJ"

 76f1:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 76f4:  61 86 00 40             JE              G76,(SP)+ [FALSE] RFALSE
 76f8:  e0 1b 2b be 2d 86 00    CALL            577c (#2d,G76) -> -(SP)
 76ff:  b0                      RTRUE           

Routine 7700, 0 locals ()
    Action routine for:
        "hide down OBJ"
"pour OBJ from OBJ"
"pour OBJ in OBJ"
"pour OBJ"
"leave OBJ"
"drop OBJ"

 7701:  e0 3f 48 eb 00          CALL            91d6 -> -(SP)
 7706:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 7709:  b3 ...                  PRINT_RET       "Dropped."

Routine 7712, 3 locals (0000, 0000, 0000)
    Action routine for:
        "bite OBJ"

 7719:  4a 86 15 c8             TEST_ATTR       G76,#15 [TRUE] 7723
 771d:  e8 7f 00                PUSH            #00
 7720:  8c 00 05                JUMP            7726
 7723:  e8 7f 01                PUSH            #01
 7726:  2d 01 00                STORE           L00,(SP)+
 7729:  a0 01 80 59             JZ              L00 [TRUE] 7784
 772d:  66 86 7f da             JIN             G76,G6f [TRUE] 7749
 7731:  a3 86 00                GET_PARENT      G76 -> -(SP)
 7734:  66 00 7f d3             JIN             (SP)+,G6f [TRUE] 7749
 7738:  b2 ...                  PRINT           "You're not holding that."
 7745:  bb                      NEW_LINE        
 7746:  8c 00 3b                JUMP            7782
 7749:  41 88 2f 54             JE              G78,#2f [FALSE] 775f
 774d:  b2 ...                  PRINT           "How can you drink that?"
 775c:  8c 00 25                JUMP            7782
 775f:  b2 ...                  PRINT           "Thank you very much. It really hit the spot."
 777c:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 7782:  bb                      NEW_LINE        
 7783:  b0                      RTRUE           
 7784:  4a 86 16 00 68          TEST_ATTR       G76,#16 [FALSE] 77ef
 7789:  0d 02 01                STORE           L01,#01
 778c:  a3 86 03                GET_PARENT      G76 -> L02
 778f:  46 86 f7 ca             JIN             G76,#f7 [TRUE] 779b
 7793:  46 86 f9 c6             JIN             G76,#f9 [TRUE] 779b
 7797:  41 86 0d 48             JE              G76,#0d [FALSE] 77a1
 779b:  e0 3f 3c 07 00          CALL            780e -> -(SP)
 77a0:  b8                      RET_POPPED      
 77a1:  a0 03 51                JZ              L02 [FALSE] 77b3
 77a4:  b3 ...                  PRINT_RET       "You don't have any to drink."
 77b3:  66 03 7f d8             JIN             L02,G6f [TRUE] 77cd
 77b7:  b2 ...                  PRINT           "You have to be holding the "
 77c4:  aa 03                   PRINT_OBJ       L02
 77c6:  b3 ...                  PRINT_RET       " first."
 77cd:  4a 03 0b da             TEST_ATTR       L02,#0b [TRUE] 77e9
 77d1:  b2 ...                  PRINT           "You'll have to open the "
 77e0:  aa 03                   PRINT_OBJ       L02
 77e2:  b3 ...                  PRINT_RET       " first."
 77e9:  e0 3f 3c 07 00          CALL            780e -> -(SP)
 77ee:  b8                      RET_POPPED      
 77ef:  a0 01 40                JZ              L00 [FALSE] RFALSE
 77f2:  a0 02 40                JZ              L01 [FALSE] RFALSE
 77f5:  b2 ...                  PRINT           "I don't think that the "
 77fe:  aa 86                   PRINT_OBJ       G76
 7800:  b3 ...                  PRINT_RET       " would agree with you."

Routine 780e, 0 locals ()

 780f:  b2 ...                  PRINT           "Thank you very much. I was rather thirsty (from all this talking, probably)."
 7840:  bb                      NEW_LINE        
 7841:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 7847:  b8                      RET_POPPED      

Routine 7848, 5 locals (0000, 0000, 0000, 0000, 0000)
    Action routine for:
        "echo"

 7853:  50 7e 01 00             LOADB           G6e,#01 -> -(SP)
 7857:  43 00 00 00 46          JG              (SP)+,#00 [FALSE] 78a0
 785c:  50 7e 01 00             LOADB           G6e,#01 -> -(SP)
 7860:  56 00 04 00             MUL             (SP)+,#04 -> -(SP)
 7864:  74 7e 00 01             ADD             G6e,(SP)+ -> L00
 7868:  50 01 00 05             LOADB           L00,#00 -> L04
 786c:  50 01 01 00             LOADB           L00,#01 -> -(SP)
 7870:  74 05 00 00             ADD             L04,(SP)+ -> -(SP)
 7874:  55 00 01 02             SUB             (SP)+,#01 -> L01
 7878:  05 03 02 47             INC_CHK         L02,#02 [FALSE] 7881
 787c:  b3 ...                  PRINT_RET       "..."
 7881:  50 01 01 00             LOADB           L00,#01 -> -(SP)
 7885:  55 00 01 04             SUB             (SP)+,#01 -> L03
 7889:  25 04 02 45             INC_CHK         L03,L01 [FALSE] 7890
 788d:  8c 00 0c                JUMP            789a
 7890:  70 7d 04 00             LOADB           G6d,L03 -> -(SP)
 7894:  e5 bf 00                PRINT_CHAR      (SP)+
 7897:  8c ff f1                JUMP            7889
 789a:  b2 ...                  PRINT           " "
 789d:  8c ff da                JUMP            7878
 78a0:  b3 ...                  PRINT_RET       "echo echo ..."

Routine 78ae, 0 locals ()
    Action routine for:
        "enchan OBJ"

 78af:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 78b4:  e0 3f 3b 67 00          CALL            76ce -> -(SP)
 78b9:  b8                      RET_POPPED      

Routine 78ba, 2 locals (0000, 0000)

 78bf:  61 01 7b 48             JE              L00,G6b [FALSE] 78c9
 78c3:  0d 7b 00                STORE           G6b,#00
 78c6:  0d 7a 00                STORE           G6a,#00
 78c9:  2d 02 52                STORE           L01,G42
 78cc:  a9 01                   REMOVE_OBJ      L00
 78ce:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 78d4:  a0 02 c1                JZ              L01 [TRUE] RTRUE
 78d7:  61 02 52 c1             JE              L01,G42 [TRUE] RTRUE
 78db:  b3 ...                  PRINT_RET       "You are left in the dark..."

Routine 78ec, 0 locals ()
    Action routine for:
        "enter"

 78ed:  e0 1f 4a 38 15 00       CALL            9470 (#15) -> -(SP)
 78f3:  b8                      RET_POPPED      

Routine 78f4, 0 locals ()
    Action routine for:
        "gaze at OBJ"
"descri OBJ"

 78f5:  51 86 08 00             GET_PROP        G76,#08 -> -(SP)
 78f9:  a0 00 ca                JZ              (SP)+ [TRUE] 7904
 78fc:  51 86 08 00             GET_PROP        G76,#08 -> -(SP)
 7900:  ad 00                   PRINT_PADDR     (SP)+
 7902:  bb                      NEW_LINE        
 7903:  b0                      RTRUE           
 7904:  4a 86 13 c6             TEST_ATTR       G76,#13 [TRUE] 790c
 7908:  4a 86 17 48             TEST_ATTR       G76,#17 [FALSE] 7912
 790c:  e0 3f 3f 14 00          CALL            7e28 -> -(SP)
 7911:  b8                      RET_POPPED      
 7912:  b2 ...                  PRINT           "There's nothing special about the "
 7923:  aa 86                   PRINT_OBJ       G76
 7925:  b3 ...                  PRINT_RET       "."

Routine 7928, 0 locals ()
    Action routine for:
        "exit OBJ"
"exit"

 7929:  e0 1f 4a 38 14 00       CALL            9470 (#14) -> -(SP)
 792f:  b8                      RET_POPPED      

Routine 7930, 0 locals ()
    Action routine for:
        "banish away OBJ"
"banish out OBJ"
"banish OBJ"

 7931:  b3 ...                  PRINT_RET       "What a bizarre concept!"

Routine 7944, 1 local (0000)
    Pre-action routine for:
        "fill OBJ"
"fill OBJ with OBJ"

 7947:  a0 87 6e                JZ              G77 [FALSE] 7976
 794a:  52 10 05 01             GET_PROP_ADDR   G00,#05 -> L00
 794e:  a0 01 e7                JZ              L00 [TRUE] 7976
 7951:  a4 01 00                GET_PROP_LEN    L00 -> -(SP)
 7954:  55 00 01 00             SUB             (SP)+,#01 -> -(SP)
 7958:  e0 1a 36 25 ee 01 00 00 CALL            6c4a (#ee,L00,(SP)+) -> -(SP)
 7960:  a0 00 c6                JZ              (SP)+ [TRUE] 7967
 7963:  0d 87 ee                STORE           G77,#ee
 7966:  b1                      RFALSE          
 7967:  b3 ...                  PRINT_RET       "There is nothing to fill it with."
 7976:  41 87 ee c0             JE              G77,#ee [TRUE] RFALSE
 797a:  e0 1a 2b be 12 87 86 00 CALL            577c (#12,G77,G76) -> -(SP)
 7982:  b0                      RTRUE           

Routine 7984, 0 locals ()
    Action routine for:
        "fill OBJ"
"fill OBJ with OBJ"

 7985:  a0 87 78                JZ              G77 [FALSE] 79be
 7988:  e0 1b 4a 50 ee 10 00    CALL            94a0 (#ee,G00) -> -(SP)
 798f:  a0 00 cb                JZ              (SP)+ [TRUE] 799b
 7992:  e0 19 2b be 3b 86 ee 00 CALL            577c (#3b,G76,#ee) -> -(SP)
 799a:  b0                      RTRUE           
 799b:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 799e:  26 ed 00 4b             JIN             "quantity of water",(SP)+ [FALSE] 79ab
 79a2:  e0 19 2b be 3b 86 ed 00 CALL            577c (#3b,G76,#ed) -> -(SP)
 79aa:  b0                      RTRUE           
 79ab:  b3 ...                  PRINT_RET       "There's nothing to fill it with."
 79be:  b3 ...                  PRINT_RET       "You may know how to do that, but I don't."

Routine 79d8, 1 local (0000)
    Action routine for:
        "search for OBJ"
"gaze for OBJ"
"find OBJ"

 79db:  a3 86 01                GET_PARENT      G76 -> L00
 79de:  c1 97 86 01 06 6d       JE              G76,#01,#06 [FALSE] 7a0f
 79e4:  b3 ...                  PRINT_RET       "Within six feet of your head, assuming you haven't left that somewhere."
 7a0f:  41 86 05 55             JE              G76,#05 [FALSE] 7a26
 7a13:  b3 ...                  PRINT_RET       "You're around here somewhere..."
 7a26:  41 01 f7 4b             JE              L00,#f7 [FALSE] 7a33
 7a2a:  b3 ...                  PRINT_RET       "You find it."
 7a33:  66 86 7f 49             JIN             G76,G6f [FALSE] 7a3e
 7a37:  b3 ...                  PRINT_RET       "You have it."
 7a3e:  66 86 10 d0             JIN             G76,G00 [TRUE] 7a50
 7a42:  e0 2b 4a 50 86 10 00    CALL            94a0 (G76,G00) -> -(SP)
 7a49:  a0 00 46                JZ              (SP)+ [FALSE] 7a50
 7a4c:  41 86 0d 4b             JE              G76,#0d [FALSE] 7a59
 7a50:  b3 ...                  PRINT_RET       "It's right here."
 7a59:  4a 01 1e 4e             TEST_ATTR       L00,#1e [FALSE] 7a69
 7a5d:  b2 ...                  PRINT           "The "
 7a60:  aa 01                   PRINT_OBJ       L00
 7a62:  b3 ...                  PRINT_RET       " has it."
 7a69:  4a 01 0a 4c             TEST_ATTR       L00,#0a [FALSE] 7a77
 7a6d:  b2 ...                  PRINT           "It's on the "
 7a72:  aa 01                   PRINT_OBJ       L00
 7a74:  b3 ...                  PRINT_RET       "."
 7a77:  4a 01 13 4c             TEST_ATTR       L00,#13 [FALSE] 7a85
 7a7b:  b2 ...                  PRINT           "It's in the "
 7a80:  aa 01                   PRINT_OBJ       L00
 7a82:  b3 ...                  PRINT_RET       "."
 7a85:  b3 ...                  PRINT_RET       "Beats me."

Routine 7a8e, 0 locals ()
    Action routine for:
        "chase OBJ"
"chase"

 7a8f:  b3 ...                  PRINT_RET       "You're nuts!"

Routine 7a96, 0 locals ()
    Action routine for:
        "froboz"

 7a97:  b3 ...                  PRINT_RET       "The FROBOZZ Corporation created, owns, and operates this dungeon."

Routine 7ac4, 0 locals ()
    Pre-action routine for:
        "hand OBJ to OBJ"
"donate OBJ to OBJ"

 7ac5:  e0 2f 4a 76 86 00       CALL            94ec (G76) -> -(SP)
 7acb:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 7ace:  b2 ...                  PRINT           "That's easy for you to say since you don't even have the "
 7aed:  aa 86                   PRINT_OBJ       G76
 7aef:  b3 ...                  PRINT_RET       "."

Routine 7af2, 0 locals ()
    Action routine for:
        "hand OBJ to OBJ"
"donate OBJ to OBJ"

 7af3:  4a 87 1e d7             TEST_ATTR       G77,#1e [TRUE] 7b0c
 7af7:  b2 ...                  PRINT           "You can't give a "
 7b00:  aa 86                   PRINT_OBJ       G76
 7b02:  b2 ...                  PRINT           " to a "
 7b07:  aa 87                   PRINT_OBJ       G77
 7b09:  b3 ...                  PRINT_RET       "!"
 7b0c:  b2 ...                  PRINT           "The "
 7b0f:  aa 87                   PRINT_OBJ       G77
 7b11:  b3 ...                  PRINT_RET       " refuses it politely."

Routine 7b20, 0 locals ()
    Action routine for:
        "hatch OBJ"

 7b21:  b3 ...                  PRINT_RET       "Bizarre!"

Routine 7b2a, 0 locals ()
    Action routine for:
        "hello OBJ"
"hello"

 7b2b:  a0 86 80 50             JZ              G76 [TRUE] 7b7d
 7b2f:  4a 86 1e 5c             TEST_ATTR       G76,#1e [FALSE] 7b4d
 7b33:  b2 ...                  PRINT           "The "
 7b36:  aa 86                   PRINT_OBJ       G76
 7b38:  b3 ...                  PRINT_RET       " bows his head to you in greeting."
 7b4d:  b2 ...                  PRINT           "It's a well known fact that only schizophrenics say "Hello" to a "
 7b78:  aa 86                   PRINT_OBJ       G76
 7b7a:  b3 ...                  PRINT_RET       "."
 7b7d:  e0 2f 27 36 46 00       CALL            4e6c (G36) -> -(SP)
 7b83:  ad 00                   PRINT_PADDR     (SP)+
 7b85:  bb                      NEW_LINE        
 7b86:  b0                      RTRUE           

Routine 7b88, 0 locals ()
    Action routine for:
        "chant"

 7b89:  b2 ...                  PRINT           "The incantation echoes back faintly, but nothing else happens."
 7bae:  bb                      NEW_LINE        
 7baf:  0d 70 00                STORE           G60,#00
 7bb2:  0d 7c 00                STORE           G6c,#00
 7bb5:  b0                      RTRUE           

Routine 7bb6, 0 locals ()
    Action routine for:
        "inflat OBJ with OBJ"
"blow up OBJ with OBJ"

 7bb7:  b3 ...                  PRINT_RET       "How can you inflate that?"

Routine 7bc6, 0 locals ()
    Action routine for:
        "is OBJ on OBJ"
"is OBJ in OBJ"

 7bc7:  66 86 87 60             JIN             G76,G77 [FALSE] 7be9
 7bcb:  b2 ...                  PRINT           "Yes, it is "
 7bd4:  4a 87 0a 48             TEST_ATTR       G77,#0a [FALSE] 7bde
 7bd8:  b2 ...                  PRINT           "on"
 7bdb:  8c 00 05                JUMP            7be1
 7bde:  b2 ...                  PRINT           "in"
 7be1:  b2 ...                  PRINT           " the "
 7be4:  aa 87                   PRINT_OBJ       G77
 7be6:  b3 ...                  PRINT_RET       "."
 7be9:  b3 ...                  PRINT_RET       "No, it isn't."

Routine 7bf4, 0 locals ()
    Action routine for:
        "kick OBJ"

 7bf5:  e0 0f 49 2e 9a 4c 00    CALL            925c (S166) -> -(SP)
 7bfc:  b8                      RET_POPPED      

Routine 7bfe, 0 locals ()
    Action routine for:
        "kiss OBJ"

 7bff:  b3 ...                  PRINT_RET       "I'd sooner kiss a pig."

Routine 7c12, 0 locals ()
    Action routine for:
        "knock on OBJ"
"knock at OBJ"

 7c13:  4a 86 17 4f             TEST_ATTR       G76,#17 [FALSE] 7c24
 7c17:  b3 ...                  PRINT_RET       "Nobody's home."
 7c24:  b2 ...                  PRINT           "Why knock on a "
 7c2f:  aa 86                   PRINT_OBJ       G76
 7c31:  b3 ...                  PRINT_RET       "?"

Routine 7c34, 0 locals ()
    Action routine for:
        "flip off OBJ"
"hide out OBJ"
"douse OBJ"
"blow out OBJ"

 7c35:  4a 86 1f 00 3e          TEST_ATTR       G76,#1f [FALSE] 7c76
 7c3a:  4a 86 14 cb             TEST_ATTR       G76,#14 [TRUE] 7c47
 7c3e:  b3 ...                  PRINT_RET       "It is already off."
 7c47:  4c 86 14                CLEAR_ATTR      G76,#14
 7c4a:  a0 52 c8                JZ              G42 [TRUE] 7c53
 7c4d:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 7c53:  b2 ...                  PRINT           "The "
 7c56:  aa 86                   PRINT_OBJ       G76
 7c58:  b2 ...                  PRINT           " is now off."
 7c61:  bb                      NEW_LINE        
 7c62:  a0 52 41                JZ              G42 [FALSE] RTRUE
 7c65:  b2 ...                  PRINT           "It is now pitch black."
 7c74:  bb                      NEW_LINE        
 7c75:  b0                      RTRUE           
 7c76:  b3 ...                  PRINT_RET       "You can't turn that off."

Routine 7c84, 0 locals ()
    Action routine for:
        "flip on OBJ with OBJ"
"flip on OBJ"
"light OBJ"
"activa OBJ"

 7c85:  4a 86 1f 71             TEST_ATTR       G76,#1f [FALSE] 7cb8
 7c89:  4a 86 14 4b             TEST_ATTR       G76,#14 [FALSE] 7c96
 7c8d:  b3 ...                  PRINT_RET       "It is already on."
 7c96:  4b 86 14                SET_ATTR        G76,#14
 7c99:  b2 ...                  PRINT           "The "
 7c9c:  aa 86                   PRINT_OBJ       G76
 7c9e:  b2 ...                  PRINT           " is now on."
 7ca7:  bb                      NEW_LINE        
 7ca8:  a0 52 41                JZ              G42 [FALSE] RTRUE
 7cab:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 7cb1:  bb                      NEW_LINE        
 7cb2:  e0 3f 3f 02 00          CALL            7e04 -> -(SP)
 7cb7:  b0                      RTRUE           
 7cb8:  b3 ...                  PRINT_RET       "You can't turn that on."

Routine 7cc6, 0 locals ()
    Action routine for:
        "launch OBJ"

 7cc7:  4a 86 1b 5b             TEST_ATTR       G76,#1b [FALSE] 7ce4
 7ccb:  b3 ...                  PRINT_RET       "You can't launch that by saying "launch"!"
 7ce4:  b3 ...                  PRINT_RET       "That's pretty weird."

Routine 7cf6, 0 locals ()
    Action routine for:
        "lean on OBJ"

 7cf7:  b3 ...                  PRINT_RET       "Getting tired?"

Routine 7d04, 2 locals (0000, 0000)
    Action routine for:
        "go over OBJ"
"dive off OBJ"
"dive from OBJ"
"dive in OBJ"
"dive across OBJ"
"dive over OBJ"
"dive"

 7d09:  a0 86 f7                JZ              G76 [TRUE] 7d41
 7d0c:  66 86 10 62             JIN             G76,G00 [FALSE] 7d30
 7d10:  4a 86 1e 58             TEST_ATTR       G76,#1e [FALSE] 7d2a
 7d14:  b2 ...                  PRINT           "The "
 7d17:  aa 86                   PRINT_OBJ       G76
 7d19:  b3 ...                  PRINT_RET       " is too big to jump over."
 7d2a:  e0 3f 43 12 00          CALL            8624 -> -(SP)
 7d2f:  b8                      RET_POPPED      
 7d30:  b3 ...                  PRINT_RET       "That would be a good trick."
 7d41:  52 10 16 01             GET_PROP_ADDR   G00,#16 -> L00
 7d45:  a0 01 80 8d             JZ              L00 [TRUE] 7dd4
 7d49:  a4 01 02                GET_PROP_LEN    L00 -> L01
 7d4c:  41 02 02 d0             JE              L01,#02 [TRUE] 7d5e
 7d50:  41 02 04 77             JE              L01,#04 [FALSE] 7d89
 7d54:  50 01 01 00             LOADB           L00,#01 -> -(SP)
 7d58:  ae 00 00                LOAD            [(SP)+] -> -(SP)
 7d5b:  a0 00 6d                JZ              (SP)+ [FALSE] 7d89
 7d5e:  b2 ...                  PRINT           "This was not a very safe place to try jumping."
 7d7b:  bb                      NEW_LINE        
 7d7c:  e0 2f 27 36 54 00       CALL            4e6c (G44) -> -(SP)
 7d82:  e0 2f 83 33 00 00       CALL            10666 ((SP)+) -> -(SP)
 7d88:  b8                      RET_POPPED      
 7d89:  41 10 58 00 42          JE              G00,#58 [FALSE] 7dce
 7d8e:  b2 ...                  PRINT           "In a feat of unaccustomed daring, you manage to land on your feet without killing yourself."
 7dc5:  bb                      NEW_LINE        
 7dc6:  bb                      NEW_LINE        
 7dc7:  e0 1f 4a 38 16 00       CALL            9470 (#16) -> -(SP)
 7dcd:  b0                      RTRUE           
 7dce:  e0 3f 43 12 00          CALL            8624 -> -(SP)
 7dd3:  b8                      RET_POPPED      
 7dd4:  e0 3f 43 12 00          CALL            8624 -> -(SP)
 7dd9:  b8                      RET_POPPED      

Routine 7dda, 0 locals ()
    Action routine for:
        "leave"

 7ddb:  e0 1f 4a 38 14 00       CALL            9470 (#14) -> -(SP)
 7de1:  b8                      RET_POPPED      

Routine 7de2, 0 locals ()
    Action routine for:
        "listen for OBJ"
"listen to OBJ"

 7de3:  b2 ...                  PRINT           "The "
 7de6:  aa 86                   PRINT_OBJ       G76
 7de8:  b3 ...                  PRINT_RET       " makes no sound."

Routine 7df6, 0 locals ()
    Action routine for:
        "lock OBJ with OBJ"

 7df7:  b3 ...                  PRINT_RET       "It doesn't seem to work."

Routine 7e04, 0 locals ()
    Action routine for:
        "gaze down OBJ"
"gaze up OBJ"
"gaze around OBJ"
"gaze"

 7e05:  e0 1f 46 4d 01 00       CALL            8c9a (#01) -> -(SP)
 7e0b:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 7e0e:  e0 1f 46 a7 01 00       CALL            8d4e (#01) -> -(SP)
 7e14:  b8                      RET_POPPED      

Routine 7e16, 0 locals ()
    Action routine for:
        "gaze behind OBJ"

 7e17:  b2 ...                  PRINT           "There is nothing behind the "
 7e22:  aa 86                   PRINT_OBJ       G76
 7e24:  b3 ...                  PRINT_RET       "."

Routine 7e28, 0 locals ()
    Action routine for:
        "gaze in OBJ"
"gaze with OBJ"
"descri on OBJ"
"descri in OBJ"

 7e29:  4a 86 17 77             TEST_ATTR       G76,#17 [FALSE] 7e62
 7e2d:  4a 86 0b 65             TEST_ATTR       G76,#0b [FALSE] 7e54
 7e31:  b2 ...                  PRINT           "The "
 7e34:  aa 86                   PRINT_OBJ       G76
 7e36:  b2 ...                  PRINT           " is open, but I can't tell what's beyond it."
 7e51:  8c 00 0e                JUMP            7e60
 7e54:  b2 ...                  PRINT           "The "
 7e57:  aa 86                   PRINT_OBJ       G76
 7e59:  b2 ...                  PRINT           " is closed."
 7e60:  bb                      NEW_LINE        
 7e61:  b0                      RTRUE           
 7e62:  4a 86 13 00 47          TEST_ATTR       G76,#13 [FALSE] 7eac
 7e67:  4a 86 1e 53             TEST_ATTR       G76,#1e [FALSE] 7e7c
 7e6b:  b3 ...                  PRINT_RET       "There is nothing special to be seen."
 7e7c:  e0 2f 48 29 86 00       CALL            9052 (G76) -> -(SP)
 7e82:  a0 00 dd                JZ              (SP)+ [TRUE] 7ea0
 7e85:  a2 86 00 4b             GET_CHILD       G76 -> -(SP) [FALSE] 7e92
 7e89:  e0 2f 47 55 86 00       CALL            8eaa (G76) -> -(SP)
 7e8f:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 7e92:  b2 ...                  PRINT           "The "
 7e95:  aa 86                   PRINT_OBJ       G76
 7e97:  b3 ...                  PRINT_RET       " is empty."
 7ea0:  b2 ...                  PRINT           "The "
 7ea3:  aa 86                   PRINT_OBJ       G76
 7ea5:  b3 ...                  PRINT_RET       " is closed."
 7eac:  b2 ...                  PRINT           "You can't look inside a "
 7eb9:  aa 86                   PRINT_OBJ       G76
 7ebb:  b3 ...                  PRINT_RET       "."

Routine 7ebe, 0 locals ()
    Action routine for:
        "gaze on OBJ"

 7ebf:  4a 86 0a 4a             TEST_ATTR       G76,#0a [FALSE] 7ecb
 7ec3:  e0 1b 2b be 39 86 00    CALL            577c (#39,G76) -> -(SP)
 7eca:  b0                      RTRUE           
 7ecb:  b2 ...                  PRINT           "Look on a "
 7ed4:  aa 86                   PRINT_OBJ       G76
 7ed6:  b3 ...                  PRINT_RET       "???"

Routine 7edc, 0 locals ()
    Action routine for:
        "gaze under OBJ"

 7edd:  b3 ...                  PRINT_RET       "There is nothing but dust there."

Routine 7eea, 0 locals ()
    Action routine for:
        "lower OBJ"

 7eeb:  e0 0f 49 2e 9a 6e 00    CALL            925c (S170) -> -(SP)
 7ef2:  b8                      RET_POPPED      

Routine 7ef4, 0 locals ()
    Action routine for:
        "make OBJ"

 7ef5:  b3 ...                  PRINT_RET       "You can't do that."

Routine 7efe, 0 locals ()
    Action routine for:
        "liquif OBJ with OBJ"

 7eff:  b2 ...                  PRINT           "It's not clear that a "
 7f0a:  aa 86                   PRINT_OBJ       G76
 7f0c:  b3 ...                  PRINT_RET       " can be melted."

Routine 7f18, 0 locals ()
    Pre-action routine for:
        "pull up OBJ"
"pull on OBJ"
"pull OBJ"
"roll OBJ"
"roll up OBJ"
"move OBJ"

 7f19:  e0 2f 4a 76 86 00       CALL            94ec (G76) -> -(SP)
 7f1f:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 7f22:  b3 ...                  PRINT_RET       "You aren't an accomplished enough juggler."

Routine 7f40, 0 locals ()
    Action routine for:
        "pull up OBJ"
"pull on OBJ"
"pull OBJ"
"roll OBJ"
"roll up OBJ"
"move OBJ"

 7f41:  4a 86 11 5a             TEST_ATTR       G76,#11 [FALSE] 7f5d
 7f45:  b2 ...                  PRINT           "Moving the "
 7f4e:  aa 86                   PRINT_OBJ       G76
 7f50:  b3 ...                  PRINT_RET       " reveals nothing."
 7f5d:  b2 ...                  PRINT           "You can't move the "
 7f66:  aa 86                   PRINT_OBJ       G76
 7f68:  b3 ...                  PRINT_RET       "."

Routine 7f6c, 0 locals ()
    Action routine for:
        "mumble"

 7f6d:  b3 ...                  PRINT_RET       "You'll have to speak up if you expect me to hear you!"

Routine 7f90, 0 locals ()
    Pre-action routine for:
        "punctu OBJ with OBJ"
"poke OBJ with OBJ"
"block down OBJ with OBJ"
"block OBJ with OBJ"

 7f91:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 7f96:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 7f99:  a0 87 c6                JZ              G77 [TRUE] 7fa0
 7f9c:  4a 87 1d c0             TEST_ATTR       G77,#1d [TRUE] RFALSE
 7fa0:  b2 ...                  PRINT           "Trying to destroy the "
 7faf:  aa 86                   PRINT_OBJ       G76
 7fb1:  b2 ...                  PRINT           " with "
 7fb4:  a0 87 4e                JZ              G77 [FALSE] 7fc3
 7fb7:  b2 ...                  PRINT           "your bare hands"
 7fc0:  8c 00 07                JUMP            7fc8
 7fc3:  b2 ...                  PRINT           "a "
 7fc6:  aa 87                   PRINT_OBJ       G77
 7fc8:  b3 ...                  PRINT_RET       " is futile."

Routine 7fd2, 0 locals ()
    Action routine for:
        "punctu OBJ with OBJ"
"poke OBJ with OBJ"
"block down OBJ with OBJ"
"block OBJ with OBJ"

 7fd3:  4a 86 1e 4a             TEST_ATTR       G76,#1e [FALSE] 7fdf
 7fd7:  e0 1b 2b be 13 86 00    CALL            577c (#13,G76) -> -(SP)
 7fde:  b0                      RTRUE           
 7fdf:  b3 ...                  PRINT_RET       "Nice try."

Routine 7fe8, 0 locals ()
    Action routine for:
        "odysse"

 7fe9:  41 10 b9 00 6d          JE              G00,#b9 [FALSE] 8059
 7fee:  26 ba 10 00 68          JIN             "cyclops",G00 [FALSE] 8059
 7ff3:  a0 a5 00 64             JZ              G95 [FALSE] 8059
 7ff7:  e0 0f 2a 43 64 9f 00    CALL            5486 (#649f) -> -(SP)
 7ffe:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 8003:  0d a5 01                STORE           G95,#01
 8006:  b2 ...                  PRINT           "The cyclops, hearing the name of his father's deadly nemesis, flees the room by knocking down the wall on the east of the room."
 804b:  bb                      NEW_LINE        
 804c:  0d 9f 01                STORE           G8f,#01
 804f:  0c ba 02                CLEAR_ATTR      "cyclops",#02
 8052:  e0 1f 3c 5d ba 00       CALL            78ba (#ba) -> -(SP)
 8058:  b8                      RET_POPPED      
 8059:  b3 ...                  PRINT_RET       "Wasn't he a sailor?"

Routine 806a, 0 locals ()
    Action routine for:
        "grease OBJ with OBJ"

 806b:  b3 ...                  PRINT_RET       "You probably put spinach in your gas tank, too."

Routine 8084, 2 locals (0000, 0000)
    Action routine for:
        "open OBJ with OBJ"
"open up OBJ"
"open OBJ"
"block in OBJ"

 8089:  4a 86 13 00 6b          TEST_ATTR       G76,#13 [FALSE] 80f7
 808e:  51 86 0a 00             GET_PROP        G76,#0a -> -(SP)
 8092:  a0 00 80 63             JZ              (SP)+ [TRUE] 80f7
 8096:  4a 86 0b 4b             TEST_ATTR       G76,#0b [FALSE] 80a3
 809a:  b3 ...                  PRINT_RET       "It is already open."
 80a3:  4b 86 0b                SET_ATTR        G76,#0b
 80a6:  4b 86 03                SET_ATTR        G76,#03
 80a9:  a2 86 00 46             GET_CHILD       G76 -> -(SP) [FALSE] 80b1
 80ad:  4a 86 0c 49             TEST_ATTR       G76,#0c [FALSE] 80b8
 80b1:  b3 ...                  PRINT_RET       "Opened."
 80b8:  a2 86 01 62             GET_CHILD       G76 -> L00 [FALSE] 80dc
 80bc:  a1 01 00 de             GET_SIBLING     L00 -> -(SP) [TRUE] 80dc
 80c0:  4a 01 03 da             TEST_ATTR       L00,#03 [TRUE] 80dc
 80c4:  51 01 0e 02             GET_PROP        L00,#0e -> L01
 80c8:  a0 02 d3                JZ              L01 [TRUE] 80dc
 80cb:  b2 ...                  PRINT           "The "
 80ce:  aa 86                   PRINT_OBJ       G76
 80d0:  b2 ...                  PRINT           " opens."
 80d7:  bb                      NEW_LINE        
 80d8:  ad 02                   PRINT_PADDR     L01
 80da:  bb                      NEW_LINE        
 80db:  b0                      RTRUE           
 80dc:  b2 ...                  PRINT           "Opening the "
 80e5:  aa 86                   PRINT_OBJ       G76
 80e7:  b2 ...                  PRINT           " reveals "
 80ee:  e0 2f 47 2c 86 00       CALL            8e58 (G76) -> -(SP)
 80f4:  b3 ...                  PRINT_RET       "."
 80f7:  4a 86 17 60             TEST_ATTR       G76,#17 [FALSE] 8119
 80fb:  4a 86 0b 4b             TEST_ATTR       G76,#0b [FALSE] 8108
 80ff:  b3 ...                  PRINT_RET       "It is already open."
 8108:  b2 ...                  PRINT           "The "
 810b:  aa 86                   PRINT_OBJ       G76
 810d:  b2 ...                  PRINT           " opens."
 8114:  bb                      NEW_LINE        
 8115:  4b 86 0b                SET_ATTR        G76,#0b
 8118:  b0                      RTRUE           
 8119:  b2 ...                  PRINT           "You must tell me how to do that to a "
 8130:  aa 86                   PRINT_OBJ       G76
 8132:  b3 ...                  PRINT_RET       "."

Routine 8136, 1 local (0000)
    Action routine for:
        "chuck OBJ OBJ"

 8139:  41 87 f8 70             JE              G77,#f8 [FALSE] 816b
 813d:  a3 7f 01                GET_PARENT      G6f -> L00
 8140:  4a 01 1b 5c             TEST_ATTR       L00,#1b [FALSE] 815e
 8144:  a3 01 00                GET_PARENT      L00 -> -(SP)
 8147:  6e 86 00                INSERT_OBJ      G76,(SP)+
 814a:  b2 ...                  PRINT           "Ahoy -- "
 8153:  aa 86                   PRINT_OBJ       G76
 8155:  b3 ...                  PRINT_RET       " overboard!"
 815e:  b3 ...                  PRINT_RET       "You're not in anything!"
 816b:  b3 ...                  PRINT_RET       "Huh?"

Routine 8170, 0 locals ()
    Action routine for:
        "pick OBJ with OBJ"
"pick OBJ"

 8171:  b3 ...                  PRINT_RET       "You can't pick that."

Routine 817c, 0 locals ()
    Action routine for:
        "play OBJ"

 817d:  b3 ...                  PRINT_RET       "That's silly!"

Routine 818a, 0 locals ()
    Action routine for:
        "fix OBJ with OBJ"

 818b:  b3 ...                  PRINT_RET       "This has no effect."

Routine 8196, 0 locals ()
    Action routine for:
        "pour OBJ on OBJ"

 8197:  41 86 ed 00 4a          JE              G76,#ed [FALSE] 81e4
 819c:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 81a2:  4a 87 19 60             TEST_ATTR       G77,#19 [FALSE] 81c4
 81a6:  4a 87 14 5c             TEST_ATTR       G77,#14 [FALSE] 81c4
 81aa:  b2 ...                  PRINT           "The "
 81ad:  aa 87                   PRINT_OBJ       G77
 81af:  b2 ...                  PRINT           " is extinguished."
 81bc:  bb                      NEW_LINE        
 81bd:  4c 87 14                CLEAR_ATTR      G77,#14
 81c0:  4c 87 19                CLEAR_ATTR      G77,#19
 81c3:  b0                      RTRUE           
 81c4:  b2 ...                  PRINT           "The water spills over the "
 81cf:  aa 87                   PRINT_OBJ       G77
 81d1:  b3 ...                  PRINT_RET       ", to the floor, and evaporates."
 81e4:  41 86 62 4b             JE              G76,#62 [FALSE] 81f1
 81e8:  e0 16 2b be 12 62 87 00 CALL            577c (#12,#62,G77) -> -(SP)
 81f0:  b8                      RET_POPPED      
 81f1:  b3 ...                  PRINT_RET       "You can't pour that."

Routine 81fc, 0 locals ()
    Action routine for:
        "pray"

 81fd:  41 10 d4 49             JE              G00,#d4 [FALSE] 8208
 8201:  e0 1f 49 5b 4e 00       CALL            92b6 (#4e) -> -(SP)
 8207:  b8                      RET_POPPED      
 8208:  b3 ...                  PRINT_RET       "If you pray enough, your prayers may be answered."

Routine 8228, 0 locals ()
    Action routine for:
        "pump up OBJ with OBJ"
"pump up OBJ"

 8229:  a0 87 d6                JZ              G77 [TRUE] 8240
 822c:  41 87 ad d2             JE              G77,#ad [TRUE] 8240
 8230:  b2 ...                  PRINT           "Pump it up with a "
 823b:  aa 87                   PRINT_OBJ       G77
 823d:  b3 ...                  PRINT_RET       "?"
 8240:  26 ad 7f 4b             JIN             "hand-held air pump",G6f [FALSE] 824d
 8244:  e0 19 2b be 17 86 ad 00 CALL            577c (#17,G76,#ad) -> -(SP)
 824c:  b8                      RET_POPPED      
 824d:  b3 ...                  PRINT_RET       "It's really not clear how."

Routine 825e, 0 locals ()
    Action routine for:
        "press on OBJ"
"press OBJ"

 825f:  e0 0f 49 2e 9a 75 00    CALL            925c (S171) -> -(SP)
 8266:  b8                      RET_POPPED      

Routine 8268, 0 locals ()
    Action routine for:
        "slide OBJ to OBJ"
"slide OBJ OBJ"
"press OBJ to OBJ"
"press OBJ OBJ"

 8269:  b3 ...                  PRINT_RET       "You can't push things to that."

Routine 827a, 0 locals ()
    Pre-action routine for:
        "chuck OBJ in OBJ"
"squeez OBJ on OBJ"
"hide OBJ in OBJ"
"move OBJ in OBJ"
"drop OBJ in OBJ"
"drop OBJ down OBJ"
"apply OBJ to OBJ"
"chuck OBJ on OBJ"
"hide OBJ on OBJ"
"drop OBJ on OBJ"

 827b:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 8280:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 8283:  e0 3f 3d 62 00          CALL            7ac4 -> -(SP)
 8288:  b8                      RET_POPPED      

Routine 828a, 1 local (0000)
    Action routine for:
        "chuck OBJ in OBJ"
"squeez OBJ on OBJ"
"hide OBJ in OBJ"
"move OBJ in OBJ"
"drop OBJ in OBJ"
"drop OBJ down OBJ"
"apply OBJ to OBJ"

 828d:  4a 87 0b da             TEST_ATTR       G77,#0b [TRUE] 82a9
 8291:  4a 87 17 c6             TEST_ATTR       G77,#17 [TRUE] 8299
 8295:  4a 87 13 d2             TEST_ATTR       G77,#13 [TRUE] 82a9
 8299:  4a 87 1b 45             TEST_ATTR       G77,#1b [FALSE] 82a0
 829d:  8c 00 0b                JUMP            82a9
 82a0:  b3 ...                  PRINT_RET       "You can't do that."
 82a9:  4a 87 0b da             TEST_ATTR       G77,#0b [TRUE] 82c5
 82ad:  b2 ...                  PRINT           "The "
 82b0:  aa 87                   PRINT_OBJ       G77
 82b2:  b2 ...                  PRINT           " isn't open."
 82bd:  bb                      NEW_LINE        
 82be:  e0 2f 4a 98 87 00       CALL            9530 (G77) -> -(SP)
 82c4:  b8                      RET_POPPED      
 82c5:  61 87 86 4f             JE              G77,G76 [FALSE] 82d6
 82c9:  b3 ...                  PRINT_RET       "How can you do that?"
 82d6:  66 86 87 53             JIN             G76,G77 [FALSE] 82eb
 82da:  b2 ...                  PRINT           "The "
 82dd:  aa 86                   PRINT_OBJ       G76
 82df:  b2 ...                  PRINT           " is already in the "
 82e6:  aa 87                   PRINT_OBJ       G77
 82e8:  b3 ...                  PRINT_RET       "."
 82eb:  e0 2f 49 16 87 01       CALL            922c (G77) -> L00
 82f1:  e0 2f 49 16 86 00       CALL            922c (G76) -> -(SP)
 82f7:  74 01 00 01             ADD             L00,(SP)+ -> L00
 82fb:  51 87 0f 00             GET_PROP        G77,#0f -> -(SP)
 82ff:  75 01 00 01             SUB             L00,(SP)+ -> L00
 8303:  51 87 0a 00             GET_PROP        G77,#0a -> -(SP)
 8307:  63 01 00 4d             JG              L00,(SP)+ [FALSE] 8316
 830b:  b3 ...                  PRINT_RET       "There's no room."
 8316:  e0 2f 4a 76 86 00       CALL            94ec (G76) -> -(SP)
 831c:  a0 00 52                JZ              (SP)+ [FALSE] 832f
 831f:  4a 86 0d 4e             TEST_ATTR       G76,#0d [FALSE] 832f
 8323:  b2 ...                  PRINT           "You don't have the "
 832a:  aa 86                   PRINT_OBJ       G76
 832c:  b3 ...                  PRINT_RET       "."
 832f:  e0 2f 4a 76 86 00       CALL            94ec (G76) -> -(SP)
 8335:  a0 00 4a                JZ              (SP)+ [FALSE] 8340
 8338:  e0 3f 48 7a 00          CALL            90f4 -> -(SP)
 833d:  a0 00 c1                JZ              (SP)+ [TRUE] RTRUE
 8340:  6e 86 87                INSERT_OBJ      G76,G77
 8343:  4b 86 03                SET_ATTR        G76,#03
 8346:  e0 2f 48 5d 86 00       CALL            90ba (G76) -> -(SP)
 834c:  b3 ...                  PRINT_RET       "Done."

Routine 8354, 0 locals ()
    Action routine for:
        "hide OBJ behind OBJ"

 8355:  b3 ...                  PRINT_RET       "That hiding place is too obvious."

Routine 836c, 0 locals ()
    Action routine for:
        "chuck OBJ on OBJ"
"hide OBJ on OBJ"
"drop OBJ on OBJ"

 836d:  41 87 08 4a             JE              G77,#08 [FALSE] 8379
 8371:  e0 1b 2b be 31 86 00    CALL            577c (#31,G76) -> -(SP)
 8378:  b0                      RTRUE           
 8379:  4a 87 0a 48             TEST_ATTR       G77,#0a [FALSE] 8383
 837d:  e0 3f 41 45 00          CALL            828a -> -(SP)
 8382:  b8                      RET_POPPED      
 8383:  b2 ...                  PRINT           "There's no good surface on the "
 8398:  aa 87                   PRINT_OBJ       G77
 839a:  b3 ...                  PRINT_RET       "."

Routine 839e, 0 locals ()
    Action routine for:
        "slide OBJ under OBJ"
"hide OBJ under OBJ"
"press OBJ under OBJ"

 839f:  b3 ...                  PRINT_RET       "You can't do that."

Routine 83a8, 0 locals ()
    Action routine for:
        "lift up OBJ"
"lift OBJ"

 83a9:  e0 3f 3f 75 00          CALL            7eea -> -(SP)
 83ae:  b8                      RET_POPPED      

Routine 83b0, 0 locals ()
    Action routine for:
        "molest OBJ"

 83b1:  b3 ...                  PRINT_RET       "What a (ahem!) strange idea."

Routine 83c8, 0 locals ()
    Pre-action routine for:
        "read OBJ with OBJ"
"read from OBJ"
"read OBJ"
"gaze at OBJ with OBJ"

 83c9:  a0 52 53                JZ              G42 [FALSE] 83dd
 83cc:  b3 ...                  PRINT_RET       "It is impossible to read in the dark."
 83dd:  a0 87 c0                JZ              G77 [TRUE] RFALSE
 83e0:  4a 87 0c c0             TEST_ATTR       G77,#0c [TRUE] RFALSE
 83e4:  b2 ...                  PRINT           "How does one look through a "
 83f5:  aa 87                   PRINT_OBJ       G77
 83f7:  b3 ...                  PRINT_RET       "?"

Routine 83fa, 0 locals ()
    Action routine for:
        "read OBJ with OBJ"
"read from OBJ"
"read OBJ"
"gaze at OBJ with OBJ"

 83fb:  4a 86 10 d6             TEST_ATTR       G76,#10 [TRUE] 8413
 83ff:  b2 ...                  PRINT           "How does one read a "
 840e:  aa 86                   PRINT_OBJ       G76
 8410:  b3 ...                  PRINT_RET       "?"
 8413:  51 86 08 00             GET_PROP        G76,#08 -> -(SP)
 8417:  ad 00                   PRINT_PADDR     (SP)+
 8419:  bb                      NEW_LINE        
 841a:  b0                      RTRUE           

Routine 841c, 0 locals ()
    Action routine for:
        "read OBJ OBJ"

 841d:  e0 1b 2b be 53 86 00    CALL            577c (#53,G76) -> -(SP)
 8424:  b0                      RTRUE           

Routine 8426, 0 locals ()
    Action routine for:
        "repent"

 8427:  b3 ...                  PRINT_RET       "It could very well be too late!"

Routine 843c, 0 locals ()
    Action routine for:
        "answer OBJ"

 843d:  b2 ...                  PRINT           "It is hardly likely that the "
 844e:  aa 86                   PRINT_OBJ       G76
 8450:  b2 ...                  PRINT           " is interested."
 845b:  bb                      NEW_LINE        
 845c:  0d 7c 00                STORE           G6c,#00
 845f:  0d 70 00                STORE           G60,#00
 8462:  b0                      RTRUE           

Routine 8464, 0 locals ()
    Action routine for:
        "peal OBJ with OBJ"
"peal OBJ"

 8465:  b3 ...                  PRINT_RET       "How, exactly, can you ring that?"

Routine 847a, 0 locals ()
    Action routine for:
        "feel OBJ with OBJ"
"feel OBJ"

 847b:  e0 0f 49 2e 9a 79 00    CALL            925c (S172) -> -(SP)
 8482:  b8                      RET_POPPED      

Routine 8484, 1 local (0000)
    Action routine for:
        "say"

 8487:  a0 7c 4b                JZ              G6c [FALSE] 8493
 848a:  b3 ...                  PRINT_RET       "Say what?"
 8493:  0d 70 00                STORE           G60,#00
 8496:  b0                      RTRUE           

orphan code fragment:

 8497:  e0 27 4a 5f 10 1e 01    CALL            94be (G00,#1e) -> L00
 849e:  a0 01 e3                JZ              L00 [TRUE] 84c2
 84a1:  b2 ...                  PRINT           "You must address the "
 84ae:  aa 01                   PRINT_OBJ       L00
 84b0:  b2 ...                  PRINT           " directly."
 84b9:  bb                      NEW_LINE        
 84ba:  0d 70 00                STORE           G60,#00
 84bd:  0d 7c 00                STORE           G6c,#00
 84c0:  ab 7c                   RET             G6c
 84c2:  6f 7e 7c 00             LOADW           G6e,G6c -> -(SP)
 84c6:  c1 8f 00 42 de 46       JE              (SP)+,"hello" [FALSE] 84d0
 84cc:  0d 70 00                STORE           G60,#00
 84cf:  b0                      RTRUE           
 84d0:  0d 70 00                STORE           G60,#00
 84d3:  0d 7c 00                STORE           G6c,#00
 84d6:  b3 ...                  PRINT_RET       "Talking to yourself is a sign of impending mental collapse."

Routine 8500, 0 locals ()
    Action routine for:
        "search in OBJ"
"search OBJ"

 8501:  b3 ...                  PRINT_RET       "You find nothing unusual."

Routine 850e, 0 locals ()
    Action routine for:
        "send for OBJ"

 850f:  4a 86 1e 54             TEST_ATTR       G76,#1e [FALSE] 8525
 8513:  b2 ...                  PRINT           "Why would you send for the "
 8520:  aa 86                   PRINT_OBJ       G76
 8522:  b3 ...                  PRINT_RET       "?"
 8525:  b3 ...                  PRINT_RET       "That doesn't make sends."

Routine 8534, 0 locals ()
    Pre-action routine for:
        "hand OBJ OBJ"
"donate OBJ OBJ"

 8535:  e0 1a 2b be 3f 87 86 00 CALL            577c (#3f,G77,G76) -> -(SP)
 853d:  b0                      RTRUE           

Routine 853e, 0 locals ()
    Action routine for:
        "hand OBJ OBJ"
"donate OBJ OBJ"

 853f:  b3 ...                  PRINT_RET       "Foo!"

Routine 8544, 0 locals ()
    Action routine for:
        "shake OBJ"

 8545:  4a 86 1e 51             TEST_ATTR       G76,#1e [FALSE] 8558
 8549:  b3 ...                  PRINT_RET       "This seems to have no effect."
 8558:  4a 86 11 db             TEST_ATTR       G76,#11 [TRUE] 8575
 855c:  b3 ...                  PRINT_RET       "You can't take it; thus, you can't shake it!"
 8575:  4a 86 13 00 7d          TEST_ATTR       G76,#13 [FALSE] 85f5
 857a:  4a 86 0b 00 44          TEST_ATTR       G76,#0b [FALSE] 85c1
 857f:  a2 86 00 79             GET_CHILD       G76 -> -(SP) [FALSE] 85ba
 8583:  e0 3f 42 fe 00          CALL            85fc -> -(SP)
 8588:  b2 ...                  PRINT           "The contents of the "
 8593:  aa 86                   PRINT_OBJ       G76
 8595:  b2 ...                  PRINT           " spills "
 859c:  4a 10 06 d0             TEST_ATTR       G00,#06 [TRUE] 85ae
 85a0:  b2 ...                  PRINT           "out and disappears"
 85ab:  8c 00 0b                JUMP            85b7
 85ae:  b2 ...                  PRINT           "to the ground"
 85b7:  b3 ...                  PRINT_RET       "."
 85ba:  b3 ...                  PRINT_RET       "Shaken."
 85c1:  a2 86 00 62             GET_CHILD       G76 -> -(SP) [FALSE] 85e5
 85c5:  b2 ...                  PRINT           "It sounds like there is something inside the "
 85e0:  aa 86                   PRINT_OBJ       G76
 85e2:  b3 ...                  PRINT_RET       "."
 85e5:  b2 ...                  PRINT           "The "
 85e8:  aa 86                   PRINT_OBJ       G76
 85ea:  b3 ...                  PRINT_RET       " sounds empty."
 85f5:  b3 ...                  PRINT_RET       "Shaken."

Routine 85fc, 1 local (0000)

 85ff:  a2 86 01 41             GET_CHILD       G76 -> L00 [FALSE] RTRUE
 8603:  4b 01 03                SET_ATTR        L00,#03
 8606:  41 10 58 48             JE              G00,#58 [FALSE] 8610
 860a:  e8 7f 4b                PUSH            #4b
 860d:  8c 00 0f                JUMP            861d
 8610:  4a 10 06 c8             TEST_ATTR       G00,#06 [TRUE] 861a
 8614:  e8 7f 0d                PUSH            #0d
 8617:  8c 00 05                JUMP            861d
 861a:  e8 bf 10                PUSH            G00
 861d:  6e 01 00                INSERT_OBJ      L00,(SP)+
 8620:  8c ff de                JUMP            85ff

Routine 8624, 0 locals ()
    Action routine for:
        "hop"

 8625:  e0 2f 27 36 53 00       CALL            4e6c (G43) -> -(SP)
 862b:  ad 00                   PRINT_PADDR     (SP)+
 862d:  bb                      NEW_LINE        
 862e:  b0                      RTRUE           

Routine 8630, 0 locals ()
    Action routine for:
        "smell OBJ"

 8631:  b2 ...                  PRINT           "It smells like a "
 863e:  aa 86                   PRINT_OBJ       G76
 8640:  b3 ...                  PRINT_RET       "."

Routine 8644, 0 locals ()
    Action routine for:
        "spin OBJ"

 8645:  b3 ...                  PRINT_RET       "You can't spin that!"

Routine 864e, 0 locals ()
    Action routine for:
        "spray OBJ on OBJ"

 864f:  e0 3f 43 2b 00          CALL            8656 -> -(SP)
 8654:  b8                      RET_POPPED      

Routine 8656, 0 locals ()
    Action routine for:
        "squeez OBJ"

 8657:  4a 86 1e 5b             TEST_ATTR       G76,#1e [FALSE] 8674
 865b:  b2 ...                  PRINT           "The "
 865e:  aa 86                   PRINT_OBJ       G76
 8660:  b2 ...                  PRINT           " does not understand this."
 8671:  8c 00 15                JUMP            8687
 8674:  b2 ...                  PRINT           "How singularly useless."
 8687:  bb                      NEW_LINE        
 8688:  b0                      RTRUE           

Routine 868a, 0 locals ()
    Action routine for:
        "spray OBJ with OBJ"

 868b:  e0 1a 2b be 77 87 86 00 CALL            577c (#77,G77,G76) -> -(SP)
 8693:  b8                      RET_POPPED      

Routine 8694, 1 local (0000)
    Action routine for:
        "stab OBJ"

 8697:  e0 2f 7d 76 7f 01       CALL            faec (G6f) -> L00
 869d:  a0 01 cb                JZ              L00 [TRUE] 86a9
 86a0:  e0 1a 2b be 13 86 01 00 CALL            577c (#13,G76,L00) -> -(SP)
 86a8:  b0                      RTRUE           
 86a9:  b2 ...                  PRINT           "No doubt you propose to stab the "
 86be:  aa 86                   PRINT_OBJ       G76
 86c0:  b3 ...                  PRINT_RET       " with your pinky?"

Routine 86ca, 0 locals ()
    Action routine for:
        "carry up OBJ"
"stand up OBJ"
"stand"

 86cb:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 86ce:  4a 00 1b 4d             TEST_ATTR       (SP)+,#1b [FALSE] 86dd
 86d2:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 86d5:  e0 1b 2b be 2d 00 00    CALL            577c (#2d,(SP)+) -> -(SP)
 86dc:  b0                      RTRUE           
 86dd:  b3 ...                  PRINT_RET       "You are already standing, I think."

Routine 86f0, 0 locals ()
    Action routine for:
        "stay"

 86f1:  b3 ...                  PRINT_RET       "You will be lost without me!"

Routine 8702, 0 locals ()
    Action routine for:
        "strike OBJ"

 8703:  4a 86 1e 00 40          TEST_ATTR       G76,#1e [FALSE] 8746
 8708:  b2 ...                  PRINT           "Since you aren't versed in hand-to-hand combat, you'd better attack the "
 8739:  aa 86                   PRINT_OBJ       G76
 873b:  b3 ...                  PRINT_RET       " with a weapon."
 8746:  e0 1b 2b be 0e 86 00    CALL            577c (#0e,G76) -> -(SP)
 874d:  b0                      RTRUE           

Routine 874e, 0 locals ()
    Action routine for:
        "bathe in OBJ"
"bathe"

 874f:  e0 1b 4a 50 ee 10 00    CALL            94a0 (#ee,G00) -> -(SP)
 8756:  a0 00 f1                JZ              (SP)+ [TRUE] 8788
 8759:  b2 ...                  PRINT           "Swimming isn't usually allowed in the "
 8774:  a0 86 ca                JZ              G76 [TRUE] 877f
 8777:  aa 86                   PRINT_OBJ       G76
 8779:  b2 ...                  PRINT           "."
 877c:  8c 00 09                JUMP            8786
 877f:  b2 ...                  PRINT           "dungeon."
 8786:  bb                      NEW_LINE        
 8787:  b0                      RTRUE           
 8788:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 878d:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 8790:  b3 ...                  PRINT_RET       "Go jump in a lake!"

Routine 87a0, 0 locals ()
    Action routine for:
        "swing OBJ at OBJ"
"swing OBJ"

 87a1:  a0 87 49                JZ              G77 [FALSE] 87ab
 87a4:  b3 ...                  PRINT_RET       "Whoosh!"
 87ab:  e0 1a 2b be 13 87 86 00 CALL            577c (#13,G77,G76) -> -(SP)
 87b3:  b8                      RET_POPPED      

Routine 87b4, 0 locals ()
    Pre-action routine for:
        "carry OBJ from OBJ"
"carry OBJ off OBJ"
"carry OBJ out OBJ"
"carry OBJ"
"pick up OBJ"

 87b5:  66 86 7f 5c             JIN             G76,G6f [FALSE] 87d3
 87b9:  4a 86 00 4f             TEST_ATTR       G76,#00 [FALSE] 87ca
 87bd:  b3 ...                  PRINT_RET       "You are already wearing it."
 87ca:  b3 ...                  PRINT_RET       "You already have that!"
 87d3:  a3 86 00                GET_PARENT      G76 -> -(SP)
 87d6:  4a 00 13 6c             TEST_ATTR       (SP)+,#13 [FALSE] 8804
 87da:  a3 86 00                GET_PARENT      G76 -> -(SP)
 87dd:  4a 00 0b e5             TEST_ATTR       (SP)+,#0b [TRUE] 8804
 87e1:  b3 ...                  PRINT_RET       "You can't reach something that's inside a closed container."
 8804:  a0 87 e8                JZ              G77 [TRUE] 882d
 8807:  41 87 08 46             JE              G77,#08 [FALSE] 880f
 880b:  0d 87 00                STORE           G77,#00
 880e:  b1                      RFALSE          
 880f:  a3 86 00                GET_PARENT      G76 -> -(SP)
 8812:  61 87 00 d5             JE              G77,(SP)+ [TRUE] 8829
 8816:  b2 ...                  PRINT           "The "
 8819:  aa 86                   PRINT_OBJ       G76
 881b:  b2 ...                  PRINT           " isn't in the "
 8824:  aa 87                   PRINT_OBJ       G77
 8826:  b3 ...                  PRINT_RET       "."
 8829:  0d 87 00                STORE           G77,#00
 882c:  b1                      RFALSE          
 882d:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 8830:  61 86 00 40             JE              G76,(SP)+ [FALSE] RFALSE
 8834:  b3 ...                  PRINT_RET       "You're inside of it!"

Routine 8840, 0 locals ()
    Action routine for:
        "carry OBJ from OBJ"
"carry OBJ off OBJ"
"carry OBJ out OBJ"
"carry OBJ"
"pick up OBJ"

 8841:  e0 3f 48 7a 00          CALL            90f4 -> -(SP)
 8846:  41 00 01 40             JE              (SP)+,#01 [FALSE] RFALSE
 884a:  4a 86 00 54             TEST_ATTR       G76,#00 [FALSE] 8860
 884e:  b2 ...                  PRINT           "You are now wearing the "
 885b:  aa 86                   PRINT_OBJ       G76
 885d:  b3 ...                  PRINT_RET       "."
 8860:  b3 ...                  PRINT_RET       "Taken."

Routine 8868, 0 locals ()
    Action routine for:
        "ask OBJ"
"talk to OBJ"

 8869:  4a 86 1e 00 41          TEST_ATTR       G76,#1e [FALSE] 88ad
 886e:  a0 7c ca                JZ              G6c [TRUE] 8879
 8871:  2d 7f 86                STORE           G6f,G76
 8874:  a3 7f 10                GET_PARENT      G6f -> G00
 8877:  ab 10                   RET             G00
 8879:  b2 ...                  PRINT           "The "
 887c:  aa 86                   PRINT_OBJ       G76
 887e:  b3 ...                  PRINT_RET       " pauses for a moment, perhaps thinking that you should re-read the manual."
 88ad:  b2 ...                  PRINT           "You can't talk to the "
 88b8:  aa 86                   PRINT_OBJ       G76
 88ba:  b2 ...                  PRINT           "!"
 88bd:  bb                      NEW_LINE        
 88be:  0d 70 00                STORE           G60,#00
 88c1:  0d 7c 00                STORE           G6c,#00
 88c4:  9b 02                   RET             #02

Routine 88c6, 2 locals (0000, 0000)
    Action routine for:
        "go on OBJ"
"go with OBJ"
"go in OBJ"
"enter OBJ"
"climb with OBJ"

 88cb:  4a 86 17 4f             TEST_ATTR       G76,#17 [FALSE] 88dc
 88cf:  e0 2f 4a 7e 86 00       CALL            94fc (G76) -> -(SP)
 88d5:  e0 2f 4a 38 00 00       CALL            9470 ((SP)+) -> -(SP)
 88db:  b0                      RTRUE           
 88dc:  a0 01 4e                JZ              L00 [FALSE] 88eb
 88df:  4a 86 1b 4a             TEST_ATTR       G76,#1b [FALSE] 88eb
 88e3:  e0 1b 2b be 19 86 00    CALL            577c (#19,G76) -> -(SP)
 88ea:  b0                      RTRUE           
 88eb:  a0 01 00 4b             JZ              L00 [FALSE] 8938
 88ef:  4a 86 11 80 46          TEST_ATTR       G76,#11 [TRUE] 8938
 88f4:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 88f9:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 88fc:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 8901:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 8904:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 8909:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 890c:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 8911:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 8914:  b2 ...                  PRINT           "You hit your head against the "
 8925:  aa 86                   PRINT_OBJ       G76
 8927:  b3 ...                  PRINT_RET       " as you attempt this feat."
 8938:  a0 01 cb                JZ              L00 [TRUE] 8944
 893b:  b3 ...                  PRINT_RET       "You can't do that!"
 8944:  66 86 7f 5b             JIN             G76,G6f [FALSE] 8961
 8948:  b3 ...                  PRINT_RET       "That would involve quite a contortion!"
 8961:  e0 2f 27 36 45 00       CALL            4e6c (G35) -> -(SP)
 8967:  ad 00                   PRINT_PADDR     (SP)+
 8969:  bb                      NEW_LINE        
 896a:  b0                      RTRUE           

Routine 896c, 0 locals ()
    Action routine for:
        "chuck OBJ with OBJ"
"chuck OBJ at OBJ"

 896d:  e0 3f 48 eb 00          CALL            91d6 -> -(SP)
 8972:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 8975:  41 87 05 5b             JE              G77,#05 [FALSE] 8992
 8979:  b2 ...                  PRINT           "A terrific throw! The "
 8988:  aa 86                   PRINT_OBJ       G76
 898a:  e0 0f 83 33 9a a6 00    CALL            10666 (S177) -> -(SP)
 8991:  b8                      RET_POPPED      
 8992:  4a 87 1e 69             TEST_ATTR       G77,#1e [FALSE] 89bd
 8996:  b2 ...                  PRINT           "The "
 8999:  aa 87                   PRINT_OBJ       G77
 899b:  b2 ...                  PRINT           " ducks as the "
 89a4:  aa 86                   PRINT_OBJ       G76
 89a6:  b3 ...                  PRINT_RET       " flies by and crashes to the ground."
 89bd:  b3 ...                  PRINT_RET       "Thrown."

Routine 89c4, 0 locals ()
    Action routine for:
        "chuck OBJ over OBJ"
"chuck OBJ off OBJ"

 89c5:  b3 ...                  PRINT_RET       "You can't throw anything off of that!"

Routine 89da, 0 locals ()
    Action routine for:
        "attach OBJ to OBJ"

 89db:  61 87 7f 57             JE              G77,G6f [FALSE] 89f4
 89df:  b3 ...                  PRINT_RET       "You can't tie anything to yourself."
 89f4:  b2 ...                  PRINT           "You can't tie the "
 89fd:  aa 86                   PRINT_OBJ       G76
 89ff:  b3 ...                  PRINT_RET       " to that."

Routine 8a06, 0 locals ()
    Action routine for:
        "attach up OBJ with OBJ"

 8a07:  b3 ...                  PRINT_RET       "You could certainly never tie it with that!"

Routine 8a20, 0 locals ()
    Action routine for:
        "temple"

 8a21:  41 10 dc 49             JE              G00,#dc [FALSE] 8a2c
 8a25:  e0 1f 49 5b be 00       CALL            92b6 (#be) -> -(SP)
 8a2b:  b8                      RET_POPPED      
 8a2c:  41 10 be 49             JE              G00,#be [FALSE] 8a37
 8a30:  e0 1f 49 5b dc 00       CALL            92b6 (#dc) -> -(SP)
 8a36:  b8                      RET_POPPED      
 8a37:  b3 ...                  PRINT_RET       "Nothing happens."

Routine 8a44, 0 locals ()
    Pre-action routine for:
        "flip OBJ for OBJ"
"flip OBJ to OBJ"
"flip OBJ with OBJ"
"press OBJ with OBJ"
"move OBJ with OBJ"

 8a45:  4a 86 0f c0             TEST_ATTR       G76,#0f [TRUE] RFALSE
 8a49:  b3 ...                  PRINT_RET       "You can't turn that!"

Routine 8a54, 0 locals ()
    Action routine for:
        "flip OBJ for OBJ"
"flip OBJ to OBJ"
"flip OBJ with OBJ"
"press OBJ with OBJ"
"move OBJ with OBJ"

 8a55:  b3 ...                  PRINT_RET       "This has no effect."

Routine 8a60, 0 locals ()
    Action routine for:
        "unlock OBJ with OBJ"

 8a61:  e0 3f 3e fb 00          CALL            7df6 -> -(SP)
 8a66:  b8                      RET_POPPED      

Routine 8a68, 0 locals ()
    Action routine for:
        "free OBJ from OBJ"
"free OBJ"

 8a69:  b3 ...                  PRINT_RET       "This cannot be tied, so it cannot be untied!"

Routine 8a7e, 1 local (0003)
    Action routine for:
        "wait"

 8a81:  b2 ...                  PRINT           "Time passes..."
 8a8e:  bb                      NEW_LINE        
 8a8f:  04 01 00 45             DEC_CHK         L00,#00 [FALSE] 8a96
 8a93:  8c 00 0b                JUMP            8a9f
 8a96:  e0 3f 2a 62 00          CALL            54c4 -> -(SP)
 8a9b:  a0 00 bf f2             JZ              (SP)+ [TRUE] 8a8f
 8a9f:  0d 91 01                STORE           G81,#01
 8aa2:  ab 91                   RET             G81

Routine 8aa4, 5 locals (0000, 0000, 0000, 0000, 0000)
    Action routine for:
        "go away OBJ"
"go OBJ"

 8aaf:  a0 6f 4a                JZ              G5f [FALSE] 8aba
 8ab2:  e0 1b 2b be 8a 86 00    CALL            577c (#8a,G76) -> -(SP)
 8ab9:  b0                      RTRUE           
 8aba:  72 10 86 01             GET_PROP_ADDR   G00,G76 -> L00
 8abe:  a0 01 80 ac             JZ              L00 [TRUE] 8b6c
 8ac2:  a4 01 02                GET_PROP_LEN    L00 -> L01
 8ac5:  41 02 01 4d             JE              L01,#01 [FALSE] 8ad4
 8ac9:  50 01 00 00             LOADB           L00,#00 -> -(SP)
 8acd:  e0 2f 49 5b 00 00       CALL            92b6 ((SP)+) -> -(SP)
 8ad3:  b8                      RET_POPPED      
 8ad4:  41 02 02 4b             JE              L01,#02 [FALSE] 8ae1
 8ad8:  4f 01 00 00             LOADW           L00,#00 -> -(SP)
 8adc:  ad 00                   PRINT_PADDR     (SP)+
 8ade:  bb                      NEW_LINE        
 8adf:  9b 02                   RET             #02
 8ae1:  41 02 03 5e             JE              L01,#03 [FALSE] 8b01
 8ae5:  4f 01 00 00             LOADW           L00,#00 -> -(SP)
 8ae9:  e0 bf 00 05             CALL            (SP)+ -> L04
 8aed:  a0 05 c9                JZ              L04 [TRUE] 8af7
 8af0:  e0 2f 49 5b 05 00       CALL            92b6 (L04) -> -(SP)
 8af6:  b8                      RET_POPPED      
 8af7:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 8afc:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 8aff:  9b 02                   RET             #02
 8b01:  41 02 04 71             JE              L01,#04 [FALSE] 8b34
 8b05:  50 01 01 00             LOADB           L00,#01 -> -(SP)
 8b09:  ae 00 00                LOAD            [(SP)+] -> -(SP)
 8b0c:  a0 00 cd                JZ              (SP)+ [TRUE] 8b1a
 8b0f:  50 01 00 00             LOADB           L00,#00 -> -(SP)
 8b13:  e0 2f 49 5b 00 00       CALL            92b6 ((SP)+) -> -(SP)
 8b19:  b8                      RET_POPPED      
 8b1a:  4f 01 01 03             LOADW           L00,#01 -> L02
 8b1e:  a0 03 c7                JZ              L02 [TRUE] 8b26
 8b21:  ad 03                   PRINT_PADDR     L02
 8b23:  bb                      NEW_LINE        
 8b24:  9b 02                   RET             #02
 8b26:  b2 ...                  PRINT           "You can't go that way."
 8b31:  bb                      NEW_LINE        
 8b32:  9b 02                   RET             #02
 8b34:  41 02 05 40             JE              L01,#05 [FALSE] RFALSE
 8b38:  50 01 01 04             LOADB           L00,#01 -> L03
 8b3c:  4a 04 0b 4d             TEST_ATTR       L03,#0b [FALSE] 8b4b
 8b40:  50 01 00 00             LOADB           L00,#00 -> -(SP)
 8b44:  e0 2f 49 5b 00 00       CALL            92b6 ((SP)+) -> -(SP)
 8b4a:  b8                      RET_POPPED      
 8b4b:  4f 01 01 03             LOADW           L00,#01 -> L02
 8b4f:  a0 03 c7                JZ              L02 [TRUE] 8b57
 8b52:  ad 03                   PRINT_PADDR     L02
 8b54:  bb                      NEW_LINE        
 8b55:  9b 02                   RET             #02
 8b57:  b2 ...                  PRINT           "The "
 8b5a:  aa 04                   PRINT_OBJ       L03
 8b5c:  b2 ...                  PRINT           " is closed."
 8b63:  bb                      NEW_LINE        
 8b64:  e0 2f 4a 98 04 00       CALL            9530 (L03) -> -(SP)
 8b6a:  9b 02                   RET             #02
 8b6c:  a0 52 00 4f             JZ              G42 [FALSE] 8bbd
 8b70:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 8b74:  23 50 00 00 46          JG              #50,(SP)+ [FALSE] 8bbd
 8b79:  4a 10 04 80 41          TEST_ATTR       G00,#04 [TRUE] 8bbd
 8b7e:  a0 51 ee                JZ              G41 [TRUE] 8bad
 8b81:  b2 ...                  PRINT           "There are odd noises in the darkness, and there is no exit in that direction."
 8baa:  bb                      NEW_LINE        
 8bab:  9b 02                   RET             #02
 8bad:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 8bb2:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 8bb5:  e0 0f 83 33 9a ea 00    CALL            10666 (S178) -> -(SP)
 8bbc:  b8                      RET_POPPED      
 8bbd:  b2 ...                  PRINT           "You can't go that way."
 8bc8:  bb                      NEW_LINE        
 8bc9:  9b 02                   RET             #02

Routine 8bcc, 0 locals ()
    Action routine for:
        "go around OBJ"

 8bcd:  b3 ...                  PRINT_RET       "Use compass directions for movement."

Routine 8be6, 0 locals ()
    Action routine for:
        "go to OBJ"

 8be7:  66 86 10 cc             JIN             G76,G00 [TRUE] 8bf5
 8beb:  e0 2b 4a 50 86 10 00    CALL            94a0 (G76,G00) -> -(SP)
 8bf2:  a0 00 c7                JZ              (SP)+ [TRUE] 8bfa
 8bf5:  b3 ...                  PRINT_RET       "It's here!"
 8bfa:  b3 ...                  PRINT_RET       "You should supply a direction!"

Routine 8c10, 0 locals ()
    Action routine for:
        "brandi OBJ at OBJ"
"brandi OBJ"

 8c11:  e0 0f 49 2e 9a fe 00    CALL            925c (S179) -> -(SP)
 8c18:  b8                      RET_POPPED      

Routine 8c1a, 0 locals ()
    Action routine for:
        "wear OBJ"
"hide on OBJ"

 8c1b:  4a 86 00 d0             TEST_ATTR       G76,#00 [TRUE] 8c2d
 8c1f:  b2 ...                  PRINT           "You can't wear the "
 8c28:  aa 86                   PRINT_OBJ       G76
 8c2a:  b3 ...                  PRINT_RET       "."
 8c2d:  e0 1b 2b be 5d 86 00    CALL            577c (#5d,G76) -> -(SP)
 8c34:  b0                      RTRUE           

Routine 8c36, 0 locals ()
    Action routine for:
        "win"

 8c37:  b3 ...                  PRINT_RET       "Naturally!"

Routine 8c40, 0 locals ()
    Action routine for:
        "wind up OBJ"
"wind OBJ"

 8c41:  b2 ...                  PRINT           "You cannot wind up a "
 8c4c:  aa 86                   PRINT_OBJ       G76
 8c4e:  b3 ...                  PRINT_RET       "."

Routine 8c52, 0 locals ()
    Action routine for:
        "wish"

 8c53:  b3 ...                  PRINT_RET       "With luck, your wish will come true."

Routine 8c6c, 0 locals ()
    Action routine for:
        "scream"

 8c6d:  b3 ...                  PRINT_RET       "Aaaarrrrgggghhhh!"

Routine 8c7c, 0 locals ()
    Action routine for:
        "zork"

 8c7d:  b3 ...                  PRINT_RET       "At your service!"

Routine 8c88, 0 locals ()

 8c89:  e0 3f 46 4d 00          CALL            8c9a -> -(SP)
 8c8e:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 8c91:  a0 56 40                JZ              G46 [FALSE] RFALSE
 8c94:  e0 3f 46 a7 00          CALL            8d4e -> -(SP)
 8c99:  b8                      RET_POPPED      

Routine 8c9a, 4 locals (0000, 0000, 0000, 0000)

 8ca3:  a0 01 c8                JZ              L00 [TRUE] 8cac
 8ca6:  e8 bf 01                PUSH            L00
 8ca9:  8c 00 05                JUMP            8caf
 8cac:  e8 bf 57                PUSH            G47
 8caf:  e9 7f 02                PULL            L01
 8cb2:  a0 52 71                JZ              G42 [FALSE] 8ce4
 8cb5:  b2 ...                  PRINT           "It is pitch black."
 8cc2:  a0 51 59                JZ              G41 [FALSE] 8cdc
 8cc5:  b2 ...                  PRINT           " You are likely to be eaten by a grue."
 8cdc:  bb                      NEW_LINE        
 8cdd:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 8ce2:  9b 00                   RET             #00
 8ce4:  4a 10 03 c8             TEST_ATTR       G00,#03 [TRUE] 8cee
 8ce8:  4b 10 03                SET_ATTR        G00,#03
 8ceb:  0d 02 01                STORE           L01,#01
 8cee:  4a 10 05 45             TEST_ATTR       G00,#05 [FALSE] 8cf5
 8cf2:  4c 10 03                CLEAR_ATTR      G00,#03
 8cf5:  46 10 52 53             JIN             G00,#52 [FALSE] 8d0a
 8cf9:  aa 10                   PRINT_OBJ       G00
 8cfb:  a3 7f 04                GET_PARENT      G6f -> L03
 8cfe:  4a 04 1b 49             TEST_ATTR       L03,#1b [FALSE] 8d09
 8d02:  b2 ...                  PRINT           ", in the "
 8d07:  aa 04                   PRINT_OBJ       L03
 8d09:  bb                      NEW_LINE        
 8d0a:  a0 01 45                JZ              L00 [FALSE] 8d10
 8d0d:  a0 56 41                JZ              G46 [FALSE] RTRUE
 8d10:  a3 7f 04                GET_PARENT      G6f -> L03
 8d13:  a0 02 ce                JZ              L01 [TRUE] 8d22
 8d16:  51 10 11 00             GET_PROP        G00,#11 -> -(SP)
 8d1a:  e0 9f 00 03 00          CALL            (SP)+ (#03) -> -(SP)
 8d1f:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 8d22:  a0 02 cf                JZ              L01 [TRUE] 8d32
 8d25:  51 10 0b 03             GET_PROP        G00,#0b -> L02
 8d29:  a0 03 c8                JZ              L02 [TRUE] 8d32
 8d2c:  ad 03                   PRINT_PADDR     L02
 8d2e:  bb                      NEW_LINE        
 8d2f:  8c 00 0b                JUMP            8d3b
 8d32:  51 10 11 00             GET_PROP        G00,#11 -> -(SP)
 8d36:  e0 9f 00 04 00          CALL            (SP)+ (#04) -> -(SP)
 8d3b:  61 10 04 c1             JE              G00,L03 [TRUE] RTRUE
 8d3f:  4a 04 1b 41             TEST_ATTR       L03,#1b [FALSE] RTRUE
 8d43:  51 04 11 00             GET_PROP        L03,#11 -> -(SP)
 8d47:  e0 9f 00 03 00          CALL            (SP)+ (#03) -> -(SP)
 8d4c:  b0                      RTRUE           

Routine 8d4e, 1 local (0000)

 8d51:  a0 52 df                JZ              G42 [TRUE] 8d71
 8d54:  a2 10 00 40             GET_CHILD       G00 -> -(SP) [FALSE] RFALSE
 8d58:  a0 01 c8                JZ              L00 [TRUE] 8d61
 8d5b:  e8 bf 01                PUSH            L00
 8d5e:  8c 00 05                JUMP            8d64
 8d61:  e8 bf 57                PUSH            G47
 8d64:  e9 7f 01                PULL            L00
 8d67:  e0 28 47 55 10 01 ff ff 00 
                               CALL            8eaa (G00,L00,#ffff) -> -(SP)
 8d70:  b8                      RET_POPPED      
 8d71:  b3 ...                  PRINT_RET       "Only bats can see in the dark. And you're not one."

Routine 8d92, 5 locals (0000, 0000, 0000, 0000, 0000)

 8d9d:  2d 50 01                STORE           G40,L00
 8da0:  a0 03 4e                JZ              L02 [FALSE] 8daf
 8da3:  51 01 09 00             GET_PROP        L00,#09 -> -(SP)
 8da7:  e0 9f 00 05 00          CALL            (SP)+ (#05) -> -(SP)
 8dac:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 8daf:  a0 03 59                JZ              L02 [FALSE] 8dc9
 8db2:  4a 01 03 c9             TEST_ATTR       L00,#03 [TRUE] 8dbd
 8db6:  51 01 0e 04             GET_PROP        L00,#0e -> L03
 8dba:  a0 04 49                JZ              L03 [FALSE] 8dc4
 8dbd:  51 01 0b 04             GET_PROP        L00,#0b -> L03
 8dc1:  a0 04 c7                JZ              L03 [TRUE] 8dc9
 8dc4:  ad 04                   PRINT_PADDR     L03
 8dc6:  8c 00 58                JUMP            8e1f
 8dc9:  a0 03 65                JZ              L02 [FALSE] 8def
 8dcc:  b2 ...                  PRINT           "There is a "
 8dd1:  aa 01                   PRINT_OBJ       L00
 8dd3:  b2 ...                  PRINT           " here"
 8dd6:  4a 01 14 51             TEST_ATTR       L00,#14 [FALSE] 8de9
 8dda:  b2 ...                  PRINT           " (providing light)"
 8de9:  b2 ...                  PRINT           "."
 8dec:  8c 00 32                JUMP            8e1f
 8def:  6f 49 03 00             LOADW           G39,L02 -> -(SP)
 8df3:  ad 00                   PRINT_PADDR     (SP)+
 8df5:  b2 ...                  PRINT           "A "
 8df8:  aa 01                   PRINT_OBJ       L00
 8dfa:  4a 01 14 54             TEST_ATTR       L00,#14 [FALSE] 8e10
 8dfe:  b2 ...                  PRINT           " (providing light)"
 8e0d:  8c 00 11                JUMP            8e1f
 8e10:  4a 01 00 4d             TEST_ATTR       L00,#00 [FALSE] 8e1f
 8e14:  b2 ...                  PRINT           " (being worn)"
 8e1f:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 8e24:  a0 03 5c                JZ              L02 [FALSE] 8e41
 8e27:  a3 7f 05                GET_PARENT      G6f -> L04
 8e2a:  a0 05 d6                JZ              L04 [TRUE] 8e41
 8e2d:  4a 05 1b 52             TEST_ATTR       L04,#1b [FALSE] 8e41
 8e31:  b2 ...                  PRINT           " (outside the "
 8e3c:  aa 05                   PRINT_OBJ       L04
 8e3e:  b2 ...                  PRINT           ")"
 8e41:  bb                      NEW_LINE        
 8e42:  e0 2f 48 29 01 00       CALL            9052 (L00) -> -(SP)
 8e48:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 8e4b:  a2 01 00 40             GET_CHILD       L00 -> -(SP) [FALSE] RFALSE
 8e4f:  e0 2a 47 55 01 02 03 00 CALL            8eaa (L00,L01,L02) -> -(SP)
 8e57:  b8                      RET_POPPED      

Routine 8e58, 6 locals (0000, 0000, 0000, 0001, 0000, 0000)

 8e65:  a2 01 02 40             GET_CHILD       L00 -> L01 [FALSE] RFALSE
 8e69:  a1 02 03 c2             GET_SIBLING     L01 -> L02 [TRUE] 8e6d
 8e6d:  a0 04 c8                JZ              L03 [TRUE] 8e76
 8e70:  0d 04 00                STORE           L03,#00
 8e73:  8c 00 0b                JUMP            8e7f
 8e76:  b2 ...                  PRINT           ", "
 8e79:  a0 03 45                JZ              L02 [FALSE] 8e7f
 8e7c:  b2 ...                  PRINT           "and "
 8e7f:  b2 ...                  PRINT           "a "
 8e82:  aa 02                   PRINT_OBJ       L01
 8e84:  a0 05 4b                JZ              L04 [FALSE] 8e90
 8e87:  a0 06 48                JZ              L05 [FALSE] 8e90
 8e8a:  2d 05 02                STORE           L04,L01
 8e8d:  8c 00 08                JUMP            8e96
 8e90:  0d 06 01                STORE           L05,#01
 8e93:  0d 05 00                STORE           L04,#00
 8e96:  2d 02 03                STORE           L01,L02
 8e99:  a0 02 3f ce             JZ              L01 [FALSE] 8e69
 8e9d:  a0 05 c1                JZ              L04 [TRUE] RTRUE
 8ea0:  a0 06 41                JZ              L05 [FALSE] RTRUE
 8ea3:  e0 2f 4a 98 05 00       CALL            9530 (L04) -> -(SP)
 8ea9:  b0                      RTRUE           

Routine 8eaa, 10 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000)
L00 = "West of House" #180
L03 = "Cretin" #4
 8ebf:  a2 01 04 41             GET_CHILD       L00 -> L03 [FALSE] RTRUE  ; get 1st child of "West of House" (cretin)
 8ec3:  a3 7f 07                GET_PARENT      G6f -> L06
 8ec6:  a0 07 c9                JZ              L06 [TRUE] 8ed0  ; If object in G6f has no parent goto $8ed0
 8ec9:  4a 07 1b 45             TEST_ATTR       L06,#1b [FALSE] 8ed0
 8ecd:  8c 00 05                JUMP            8ed3
 8ed0:  0d 07 00                STORE           L06,#00
 8ed3:  0d 05 01                STORE           L04,#01
 8ed6:  0d 06 01                STORE           L05,#01
 8ed9:  a3 01 00                GET_PARENT      L00 -> -(SP)
 8edc:  c1 ab 7f 01 00 48       JE              G6f,L00,(SP)+ [FALSE] 8ee8
 8ee2:  0d 0a 01                STORE           L09,#01
 8ee5:  8c 00 5f                JUMP            8f45
 8ee8:  a0 04 45                JZ              L03 [FALSE] 8eee
 8eeb:  8c 00 59                JUMP            8f45
 8eee:  61 04 07 48             JE              L03,L06 [FALSE] 8ef8
 8ef2:  0d 09 01                STORE           L08,#01
 8ef5:  8c 00 48                JUMP            8f3e
 8ef8:  61 04 7f 45             JE              L03,G6f [FALSE] 8eff
 8efc:  8c 00 41                JUMP            8f3e
 8eff:  4a 04 07 80 3c          TEST_ATTR       L03,#07 [TRUE] 8f3e
 8f04:  4a 04 03 f8             TEST_ATTR       L03,#03 [TRUE] 8f3e
 ;; Get the prop value of the object and put it into L07
 8f08:  51 04 0e 08             GET_PROP        L03,#0e -> L07
 8f0c:  a0 08 f1                JZ              L07 [TRUE] 8f3e
 8f0f:  4a 04 0e c8             TEST_ATTR       L03,#0e [TRUE] 8f19
 ;; L07 contains a value too small to be a proper packed address
 8f13:  ad 08                   PRINT_PADDR     L07
 8f15:  bb                      NEW_LINE        
 8f16:  0d 06 00                STORE           L05,#00
 8f19:  e0 2f 48 29 04 00       CALL            9052 (L03) -> -(SP)
 8f1f:  a0 00 de                JZ              (SP)+ [TRUE] 8f3e
 8f22:  a3 04 00                GET_PARENT      L03 -> -(SP)
 8f25:  51 00 09 00             GET_PROP        (SP)+,#09 -> -(SP)
 8f29:  a0 00 54                JZ              (SP)+ [FALSE] 8f3e
 8f2c:  a2 04 00 50             GET_CHILD       L03 -> -(SP) [FALSE] 8f3e
 8f30:  e0 29 47 55 04 02 00 00 CALL            8eaa (L03,L01,#00) -> -(SP)
 8f38:  a0 00 c5                JZ              (SP)+ [TRUE] 8f3e
 8f3b:  0d 05 00                STORE           L04,#00
 8f3e:  a1 04 04 c2             GET_SIBLING     L03 -> L03 [TRUE] 8f42
 8f42:  8c ff a5                JUMP            8ee8
 8f45:  a2 01 04 c2             GET_CHILD       L00 -> L03 [TRUE] 8f49
 8f49:  a0 04 5c                JZ              L03 [FALSE] 8f66
 8f4c:  a0 09 80 82             JZ              L08 [TRUE] 8fd0
 8f50:  a0 07 80 7e             JZ              L06 [TRUE] 8fd0
 8f54:  a2 07 00 00 79          GET_CHILD       L06 -> -(SP) [FALSE] 8fd0
 8f59:  95 03                   INC             L02
 8f5b:  e0 2a 47 55 07 02 03 00 CALL            8eaa (L06,L01,L02) -> -(SP)
 8f63:  8c 00 6c                JUMP            8fd0
 8f66:  c1 a7 04 07 04 45       JE              L03,L06,#04 [FALSE] 8f6f
 8f6c:  8c 00 5c                JUMP            8fc9
 8f6f:  4a 04 07 80 57          TEST_ATTR       L03,#07 [TRUE] 8fc9
 8f74:  a0 0a 4e                JZ              L09 [FALSE] 8f83
 8f77:  4a 04 03 ca             TEST_ATTR       L03,#03 [TRUE] 8f83
 8f7b:  51 04 0e 00             GET_PROP        L03,#0e -> -(SP)
 8f7f:  a0 00 00 48             JZ              (SP)+ [FALSE] 8fc9
 8f83:  4a 04 0e ed             TEST_ATTR       L03,#0e [TRUE] 8fb2
 8f87:  a0 05 d8                JZ              L04 [TRUE] 8fa0
 8f8a:  e0 2b 47 ec 01 03 00    CALL            8fd8 (L00,L02) -> -(SP)
 8f91:  a0 00 c9                JZ              (SP)+ [TRUE] 8f9b
 8f94:  42 03 00 45             JL              L02,#00 [FALSE] 8f9b
 8f98:  0d 03 00                STORE           L02,#00
 8f9b:  95 03                   INC             L02
 8f9d:  0d 05 00                STORE           L04,#00
 8fa0:  42 03 00 45             JL              L02,#00 [FALSE] 8fa7
 8fa4:  0d 03 00                STORE           L02,#00
 8fa7:  e0 2a 46 c9 04 02 03 00 CALL            8d92 (L03,L01,L02) -> -(SP)
 8faf:  8c 00 19                JUMP            8fc9
 8fb2:  a2 04 00 55             GET_CHILD       L03 -> -(SP) [FALSE] 8fc9
 8fb6:  e0 2f 48 29 04 00       CALL            9052 (L03) -> -(SP)
 8fbc:  a0 00 cc                JZ              (SP)+ [TRUE] 8fc9
 8fbf:  95 03                   INC             L02
 8fc1:  e0 2a 47 55 04 02 03 00 CALL            8eaa (L03,L01,L02) -> -(SP)
 8fc9:  a1 04 04 c2             GET_SIBLING     L03 -> L03 [TRUE] 8fcd
 8fcd:  8c ff 7b                JUMP            8f49
 8fd0:  a0 05 c1                JZ              L04 [TRUE] RTRUE
 8fd3:  a0 06 c1                JZ              L05 [TRUE] RTRUE
 8fd6:  b1                      RFALSE          

Routine 8fd8, 2 locals (0000, 0000)

 8fdd:  41 01 c2 5d             JE              L00,#c2 [FALSE] 8ffc
 8fe1:  b3 ...                  PRINT_RET       "Your collection of treasures consists of:"
 8ffc:  61 01 7f 4d             JE              L00,G6f [FALSE] 900b
 9000:  b3 ...                  PRINT_RET       "You are carrying:"
 900b:  46 01 52 c0             JIN             L00,#52 [TRUE] RFALSE
 900f:  43 02 00 48             JG              L01,#00 [FALSE] 9019
 9013:  6f 49 02 00             LOADW           G39,L01 -> -(SP)
 9017:  ad 00                   PRINT_PADDR     (SP)+
 9019:  4a 01 0a 54             TEST_ATTR       L00,#0a [FALSE] 902f
 901d:  b2 ...                  PRINT           "Sitting on the "
 9028:  aa 01                   PRINT_OBJ       L00
 902a:  b3 ...                  PRINT_RET       " is: "
 902f:  4a 01 1e 52             TEST_ATTR       L00,#1e [FALSE] 9043
 9033:  b2 ...                  PRINT           "The "
 9036:  aa 01                   PRINT_OBJ       L00
 9038:  b3 ...                  PRINT_RET       " is holding: "
 9043:  b2 ...                  PRINT           "The "
 9046:  aa 01                   PRINT_OBJ       L00
 9048:  b3 ...                  PRINT_RET       " contains:"

Routine 9052, 1 local (0000)

 9055:  4a 01 07 c0             TEST_ATTR       L00,#07 [TRUE] RFALSE
 9059:  4a 01 0c c1             TEST_ATTR       L00,#0c [TRUE] RTRUE
 905d:  4a 01 0b c1             TEST_ATTR       L00,#0b [TRUE] RTRUE
 9061:  b1                      RFALSE          

Routine 9062, 1 local (0000)

 9065:  74 4f 01 4f             ADD             G3f,L00 -> G3f
 9069:  74 11 01 11             ADD             G01,L00 -> G01
 906d:  c1 8f 11 01 5e 41       JE              G01,#015e [FALSE] RTRUE
 9073:  a0 9c 41                JZ              G8c [FALSE] RTRUE
 9076:  0d 9c 01                STORE           G8c,#01
 9079:  0c 6d 07                CLEAR_ATTR      "ancient map",#07
 907c:  0c b4 03                CLEAR_ATTR      "West of House",#03
 907f:  b3 ...                  PRINT_RET       "An almost inaudible voice whispers in your ear, "Look to your treasures for the final secret.""

Routine 90ba, 2 locals (0000, 0000)

 90bf:  51 01 0d 02             GET_PROP        L00,#0d -> L01
 90c3:  43 02 00 40             JG              L01,#00 [FALSE] RFALSE
 90c7:  e0 2f 48 31 02 00       CALL            9062 (L01) -> -(SP)
 90cd:  e3 97 01 0d 00          PUT_PROP        L00,#0d,#00
 90d2:  b0                      RTRUE           

Routine 90d4, 0 locals ()

 90d5:  e0 3f 82 c1 00          CALL            10582 -> -(SP)
 90da:  ba                      QUIT            

Routine 90dc, 0 locals ()

 90dd:  b2 ...                  PRINT           ">"
 90e2:  e4 af 7d 7e             READ            G6d,G6e
 90e6:  4f 7e 01 00             LOADW           G6e,#01 -> -(SP)
 90ea:  c1 83 00 4e 14 4d f8 40 JE              (SP)+,"yes","y" [FALSE] RFALSE
 90f2:  b0                      RTRUE           

Routine 90f4, 4 locals (0001, 0000, 0000, 0000)

 90fd:  a0 4e da                JZ              G3e [TRUE] 9118
 9100:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 9103:  b2 ...                  PRINT           "Your hand passes through its object."
 9116:  bb                      NEW_LINE        
 9117:  b1                      RFALSE          
 9118:  4a 86 11 cf             TEST_ATTR       G76,#11 [TRUE] 9129
 911c:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 911f:  e0 2f 27 36 45 00       CALL            4e6c (G35) -> -(SP)
 9125:  ad 00                   PRINT_PADDR     (SP)+
 9127:  bb                      NEW_LINE        
 9128:  b1                      RFALSE          
 9129:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 912e:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 9131:  a3 86 00                GET_PARENT      G76 -> -(SP)
 9134:  4a 00 13 49             TEST_ATTR       (SP)+,#13 [FALSE] 913f
 9138:  a3 86 00                GET_PARENT      G76 -> -(SP)
 913b:  4a 00 0b 40             TEST_ATTR       (SP)+,#0b [FALSE] RFALSE
 913f:  a3 86 00                GET_PARENT      G76 -> -(SP)
 9142:  66 00 7f 80 4c          JIN             (SP)+,G6f [TRUE] 9191
 9147:  e0 2f 49 16 86 04       CALL            922c (G76) -> L03
 914d:  e0 2f 49 16 7f 00       CALL            922c (G6f) -> -(SP)
 9153:  74 04 00 00             ADD             L03,(SP)+ -> -(SP)
 9157:  63 00 95 78             JG              (SP)+,G85 [FALSE] 9191
 915b:  a0 01 f3                JZ              L00 [TRUE] 918f
 915e:  b2 ...                  PRINT           "Your load is too heavy"
 916b:  62 95 96 5e             JL              G85,G86 [FALSE] 918b
 916f:  b2 ...                  PRINT           ", especially in light of your condition."
 9188:  8c 00 05                JUMP            918e
 918b:  b2 ...                  PRINT           "."
 918e:  bb                      NEW_LINE        
 918f:  9b 02                   RET             #02
 9191:  41 88 5d 71             JE              G78,#5d [FALSE] 91c4
 9195:  e0 2f 49 0a 7f 02       CALL            9214 (G6f) -> L01
 919b:  63 02 4b 67             JG              L01,G3b [FALSE] 91c4
 919f:  76 02 4a 04             MUL             L01,G3a -> L03
 91a3:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 91a7:  63 04 00 5b             JG              L03,(SP)+ [FALSE] 91c4
 91ab:  b2 ...                  PRINT           "You're holding too many things already!"
 91c2:  bb                      NEW_LINE        
 91c3:  b1                      RFALSE          
 91c4:  6e 86 7f                INSERT_OBJ      G76,G6f
 91c7:  4b 86 03                SET_ATTR        G76,#03
 91ca:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 91cf:  e0 2f 48 5d 86 00       CALL            90ba (G76) -> -(SP)
 91d5:  b0                      RTRUE           

Routine 91d6, 0 locals ()

 91d7:  66 86 7f db             JIN             G76,G6f [TRUE] 91f4
 91db:  a3 86 00                GET_PARENT      G76 -> -(SP)
 91de:  66 00 7f d4             JIN             (SP)+,G6f [TRUE] 91f4
 91e2:  b2 ...                  PRINT           "You're not carrying the "
 91ed:  aa 86                   PRINT_OBJ       G76
 91ef:  b2 ...                  PRINT           "."
 91f2:  bb                      NEW_LINE        
 91f3:  b1                      RFALSE          
 91f4:  66 86 7f d7             JIN             G76,G6f [TRUE] 920d
 91f8:  a3 86 00                GET_PARENT      G76 -> -(SP)
 91fb:  4a 00 0b d0             TEST_ATTR       (SP)+,#0b [TRUE] 920d
 91ff:  b2 ...                  PRINT           "The "
 9202:  aa 86                   PRINT_OBJ       G76
 9204:  b2 ...                  PRINT           " is closed."
 920b:  bb                      NEW_LINE        
 920c:  b1                      RFALSE          
 920d:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 9210:  6e 86 00                INSERT_OBJ      G76,(SP)+
 9213:  b0                      RTRUE           

Routine 9214, 3 locals (0000, 0000, 0000)

 921b:  a2 01 03 4d             GET_CHILD       L00 -> L02 [FALSE] 922a
 921f:  4a 03 00 c4             TEST_ATTR       L02,#00 [TRUE] 9225
 9223:  95 02                   INC             L01
 9225:  a1 03 03 bf f7          GET_SIBLING     L02 -> L02 [TRUE] 921f
 922a:  ab 02                   RET             L01

Routine 922c, 3 locals (0000, 0000, 0000)

 9233:  a2 01 02 5e             GET_CHILD       L00 -> L01 [FALSE] 9253
 9237:  61 01 90 4b             JE              L00,G80 [FALSE] 9244
 923b:  4a 02 00 47             TEST_ATTR       L01,#00 [FALSE] 9244
 923f:  95 03                   INC             L02
 9241:  8c 00 0c                JUMP            924e
 9244:  e0 2f 49 16 02 00       CALL            922c (L01) -> -(SP)
 924a:  74 03 00 03             ADD             L02,(SP)+ -> L02
 924e:  a1 02 02 bf e6          GET_SIBLING     L01 -> L01 [TRUE] 9237
 9253:  51 01 0f 00             GET_PROP        L00,#0f -> -(SP)
 9257:  74 03 00 00             ADD             L02,(SP)+ -> -(SP)
 925b:  b8                      RET_POPPED      

Routine 925c, 1 local (0000)

 925f:  46 86 f7 57             JIN             G76,#f7 [FALSE] 9278
 9263:  c1 95 88 54 69 8c 50    JE              G78,#54,#69,#8c [FALSE] 9278
 926a:  b2 ...                  PRINT           "The "
 926d:  aa 86                   PRINT_OBJ       G76
 926f:  b3 ...                  PRINT_RET       " isn't here!"
 9278:  ad 01                   PRINT_PADDR     L00
 927a:  aa 86                   PRINT_OBJ       G76
 927c:  e0 2f 27 36 48 00       CALL            4e6c (G38) -> -(SP)
 9282:  ad 00                   PRINT_PADDR     (SP)+
 9284:  bb                      NEW_LINE        
 9285:  b0                      RTRUE           

Routine 9286, 2 locals (0000, 0000)

 928b:  a0 01 d5                JZ              L00 [TRUE] 92a1
 928e:  b2 ...                  PRINT           "You can't go there in a "
 9299:  aa 02                   PRINT_OBJ       L01
 929b:  b2 ...                  PRINT           "."
 929e:  8c 00 15                JUMP            92b4
 92a1:  b2 ...                  PRINT           "You can't go there without a vehicle."
 92b4:  bb                      NEW_LINE        
 92b5:  b0                      RTRUE           

Routine 92b6, 6 locals (0000, 0001, 0000, 0000, 0000, 0000)

 92c3:  4a 01 06 c8             TEST_ATTR       L00,#06 [TRUE] 92cd
 92c7:  e8 7f 00                PUSH            #00
 92ca:  8c 00 05                JUMP            92d0
 92cd:  e8 7f 01                PUSH            #01
 92d0:  2d 03 00                STORE           L02,(SP)+
 92d3:  a3 7f 04                GET_PARENT      G6f -> L03
 92d6:  2d 06 52                STORE           L05,G42
 92d9:  4a 04 1b 46             TEST_ATTR       L03,#1b [FALSE] 92e1
 92dd:  51 04 06 05             GET_PROP        L03,#06 -> L04
 92e1:  a0 03 4d                JZ              L02 [FALSE] 92ef
 92e4:  a0 05 4a                JZ              L04 [FALSE] 92ef
 92e7:  e0 2b 49 43 05 04 00    CALL            9286 (L04,L03) -> -(SP)
 92ee:  b1                      RFALSE          
 92ef:  a0 03 4e                JZ              L02 [FALSE] 92fe
 92f2:  6a 01 05 ca             TEST_ATTR       L00,L04 [TRUE] 92fe
 92f6:  e0 2b 49 43 05 04 00    CALL            9286 (L04,L03) -> -(SP)
 92fd:  b1                      RFALSE          
 92fe:  4a 10 06 58             TEST_ATTR       G00,#06 [FALSE] 9318
 9302:  a0 03 d5                JZ              L02 [TRUE] 9318
 9305:  a0 05 d2                JZ              L04 [TRUE] 9318
 9308:  41 05 06 ce             JE              L04,#06 [TRUE] 9318
 930c:  6a 01 05 ca             TEST_ATTR       L00,L04 [TRUE] 9318
 9310:  e0 2b 49 43 05 04 00    CALL            9286 (L04,L03) -> -(SP)
 9317:  b1                      RFALSE          
 9318:  4a 01 12 4a             TEST_ATTR       L00,#12 [FALSE] 9324
 931c:  51 01 0b 00             GET_PROP        L00,#0b -> -(SP)
 9320:  ad 00                   PRINT_PADDR     (SP)+
 9322:  bb                      NEW_LINE        
 9323:  b1                      RFALSE          
 9324:  a0 03 e7                JZ              L02 [TRUE] 934c
 9327:  4a 10 06 e3             TEST_ATTR       G00,#06 [TRUE] 934c
 932b:  a0 4e 60                JZ              G3e [FALSE] 934c
 932e:  4a 04 1b 5c             TEST_ATTR       L03,#1b [FALSE] 934c
 9332:  b2 ...                  PRINT           "The "
 9335:  aa 04                   PRINT_OBJ       L03
 9337:  b2 ...                  PRINT           " comes to a rest on the shore."
 934a:  bb                      NEW_LINE        
 934b:  bb                      NEW_LINE        
 934c:  a0 05 c8                JZ              L04 [TRUE] 9355
 934f:  6e 04 01                INSERT_OBJ      L03,L00
 9352:  8c 00 05                JUMP            9358
 9355:  6e 7f 01                INSERT_OBJ      G6f,L00
 9358:  2d 10 01                STORE           G00,L00
 935b:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 9361:  a0 06 00 7c             JZ              L05 [FALSE] 93df
 9365:  a0 52 00 78             JZ              G42 [FALSE] 93df
 9369:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 936d:  23 50 00 00 6f          JG              #50,(SP)+ [FALSE] 93df
 9372:  a0 51 ef                JZ              G41 [TRUE] 93a2
 9375:  b2 ...                  PRINT           "There are sinister gurgling noises in the darkness all around you!"
 939e:  bb                      NEW_LINE        
 939f:  8c 00 3f                JUMP            93df
 93a2:  e0 3f 28 68 00          CALL            50d0 -> -(SP)
 93a7:  a0 00 40                JZ              (SP)+ [FALSE] RFALSE
 93aa:  b2 ...                  PRINT           "Oh, no! A lurking grue slithered into the "
 93c5:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 93c8:  4a 00 1b 4a             TEST_ATTR       (SP)+,#1b [FALSE] 93d4
 93cc:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 93cf:  aa 00                   PRINT_OBJ       (SP)+
 93d1:  8c 00 05                JUMP            93d7
 93d4:  b2 ...                  PRINT           "room"
 93d7:  e0 0f 83 33 9b 22 00    CALL            10666 (S188) -> -(SP)
 93de:  b0                      RTRUE           
 93df:  a0 52 5d                JZ              G42 [FALSE] 93fd
 93e2:  41 7f 04 59             JE              G6f,#04 [FALSE] 93fd
 93e6:  b2 ...                  PRINT           "You have moved into a dark place."
 93f9:  bb                      NEW_LINE        
 93fa:  0d 7c 00                STORE           G6c,#00
 93fd:  51 10 11 00             GET_PROP        G00,#11 -> -(SP)
 9401:  e0 9f 00 02 00          CALL            (SP)+ (#02) -> -(SP)
 9406:  e0 2f 48 5d 01 00       CALL            90ba (L00) -> -(SP)
 940c:  61 10 01 41             JE              G00,L00 [FALSE] RTRUE
 9410:  21 04 7f d2             JE              #04,G6f [TRUE] 9424
 9414:  b2 ...                  PRINT           "The "
 9417:  aa 7f                   PRINT_OBJ       G6f
 9419:  b3 ...                  PRINT_RET       " leaves the room."
 9424:  a0 02 c1                JZ              L01 [TRUE] RTRUE
 9427:  e0 3f 46 44 00          CALL            8c88 -> -(SP)
 942c:  b0                      RTRUE           

Routine 942e, 2 locals (0000, 0000)

 9433:  e0 2b 4a 24 10 01 02    CALL            9448 (G00,L00) -> L01
 943a:  a0 02 c0                JZ              L01 [TRUE] RFALSE
 943d:  e0 2f 49 5b 02 00       CALL            92b6 (L01) -> -(SP)
 9443:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
 9446:  9b 02                   RET             #02

Routine 9448, 4 locals (0000, 0000, 0000, 0000)

 9451:  4f 02 00 04             LOADW           L01,#00 -> L03
 9455:  25 03 04 c0             INC_CHK         L02,L03 [TRUE] RFALSE
 9459:  6f 02 03 00             LOADW           L01,L02 -> -(SP)
 945d:  61 00 01 3f f5          JE              (SP)+,L00 [FALSE] 9455
 9462:  61 03 04 c0             JE              L02,L03 [TRUE] RFALSE
 9466:  54 03 01 00             ADD             L02,#01 -> -(SP)
 946a:  6f 02 00 00             LOADW           L01,(SP)+ -> -(SP)
 946e:  ab 00                   RET             (SP)+

Routine 9470, 1 local (0000)

 9473:  2d 6f 01                STORE           G5f,L00
 9476:  e0 1b 2b be 89 01 00    CALL            577c (#89,L00) -> -(SP)
 947d:  b8                      RET_POPPED      

Routine 947e, 4 locals (0000, 0000, 0000, 0000)

 9487:  52 01 12 03             GET_PROP_ADDR   L00,#12 -> L02
 948b:  a4 03 00                GET_PROP_LEN    L02 -> -(SP)
 948e:  57 00 02 00             DIV             (SP)+,#02 -> -(SP)
 9492:  55 00 01 00             SUB             (SP)+,#01 -> -(SP)
 9496:  e0 2a 36 11 02 03 00 00 CALL            6c22 (L01,L02,(SP)+) -> -(SP)
 949e:  b8                      RET_POPPED      

Routine 94a0, 3 locals (0000, 0000, 0000)

 94a7:  52 02 05 03             GET_PROP_ADDR   L01,#05 -> L02
 94ab:  a0 03 c0                JZ              L02 [TRUE] RFALSE
 94ae:  a4 03 00                GET_PROP_LEN    L02 -> -(SP)
 94b1:  55 00 01 00             SUB             (SP)+,#01 -> -(SP)
 94b5:  e0 2a 36 25 01 03 00 00 CALL            6c4a (L00,L02,(SP)+) -> -(SP)
 94bd:  b8                      RET_POPPED      

Routine 94be, 3 locals (0000, 0000, 0000)

 94c5:  a2 01 03 c2             GET_CHILD       L00 -> L02 [TRUE] 94c9
 94c9:  a0 03 c0                JZ              L02 [TRUE] RFALSE
 94cc:  6a 03 02 48             TEST_ATTR       L02,L01 [FALSE] 94d6
 94d0:  41 03 04 c4             JE              L02,#04 [TRUE] 94d6
 94d4:  ab 03                   RET             L02
 94d6:  a1 03 03 bf f3          GET_SIBLING     L02 -> L02 [TRUE] 94cc
 94db:  b1                      RFALSE          

Routine 94dc, 1 local (0000)

 94df:  66 01 10 c1             JIN             L00,G00 [TRUE] RTRUE
 94e3:  e0 2b 4a 50 01 10 00    CALL            94a0 (L00,G00) -> -(SP)
 94ea:  b8                      RET_POPPED      

Routine 94ec, 1 local (0000)

 94ef:  a3 01 01                GET_PARENT      L00 -> L00
 94f2:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 94f5:  61 01 7f 3f f7          JE              L00,G6f [FALSE] 94ef
 94fa:  b0                      RTRUE           

Routine 94fc, 3 locals (0000, 0000, 0000)

 9503:  73 10 02 02             GET_NEXT_PROP   G00,L01 -> L01
 9507:  62 02 a8 c0             JL              L01,G98 [TRUE] RFALSE
 950b:  72 10 02 03             GET_PROP_ADDR   G00,L01 -> L02
 950f:  a4 03 00                GET_PROP_LEN    L02 -> -(SP)
 9512:  41 00 05 3f ee          JE              (SP)+,#05 [FALSE] 9503
 9517:  50 03 01 00             LOADB           L02,#01 -> -(SP)
 951b:  61 00 01 3f e5          JE              (SP)+,L00 [FALSE] 9503
 9520:  ab 02                   RET             L01

Routine 9522, 2 locals (0000, 0000)

 9527:  4b 01 12                SET_ATTR        L00,#12
 952a:  e3 9b 01 0b 02          PUT_PROP        L00,#0b,L01
 952f:  b0                      RTRUE           

Routine 9530, 1 local (0000)

 9533:  2d 7b 01                STORE           G6b,L00
 9536:  2d 7a 10                STORE           G6a,G00
 9539:  ab 7a                   RET             G6a

Routine 953c, 1 local (0000)

 953f:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 9543:  b2 ...                  PRINT           "You are standing in an open field west of a white house, with a boarded front door."
 9574:  a0 9c dd                JZ              G8c [TRUE] 9592
 9577:  b2 ...                  PRINT           " A secret path leads southwest into the forest."
 9592:  bb                      NEW_LINE        
 9593:  b0                      RTRUE           

Routine 9594, 1 local (0000)

 9597:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 959b:  b2 ...                  PRINT           "You are behind the white house. A path leads into the forest to the east. In one corner of the house there is a small window which is "
 95e0:  0a eb 0b 4a             TEST_ATTR       "kitchen window",#0b [FALSE] 95ec
 95e4:  b2 ...                  PRINT           "open."
 95e9:  8c 00 0d                JUMP            95f7
 95ec:  b2 ...                  PRINT           "slightly ajar."
 95f7:  bb                      NEW_LINE        
 95f8:  b0                      RTRUE           

Routine 95fa, 3 locals (0000, 0000, 0000)

 9601:  41 88 2b 58             JE              G78,#2b [FALSE] 961b
 9605:  4a 01 0b 4d             TEST_ATTR       L00,#0b [FALSE] 9614
 9609:  e0 2f 27 36 44 00       CALL            4e6c (G34) -> -(SP)
 960f:  ad 00                   PRINT_PADDR     (SP)+
 9611:  8c 00 07                JUMP            9619
 9614:  ad 02                   PRINT_PADDR     L01
 9616:  4b 01 0b                SET_ATTR        L00,#0b
 9619:  bb                      NEW_LINE        
 961a:  b0                      RTRUE           
 961b:  41 88 23 40             JE              G78,#23 [FALSE] RFALSE
 961f:  4a 01 0b 4a             TEST_ATTR       L00,#0b [FALSE] 962b
 9623:  ad 03                   PRINT_PADDR     L02
 9625:  4c 01 0b                CLEAR_ATTR      L00,#0b
 9628:  8c 00 0a                JUMP            9633
 962b:  e0 2f 27 36 44 00       CALL            4e6c (G34) -> -(SP)
 9631:  ad 00                   PRINT_PADDR     (SP)+
 9633:  bb                      NEW_LINE        
 9634:  b0                      RTRUE           

Routine 9636, 0 locals ()

 9637:  c1 97 88 38 5d 40       JE              G78,#38,#5d [FALSE] RFALSE
 963d:  b3 ...                  PRINT_RET       "The boards are securely fastened."

Routine 9652, 0 locals ()

 9653:  41 88 1a 40             JE              G78,#1a [FALSE] RFALSE
 9657:  41 86 f8 40             JE              G76,#f8 [FALSE] RFALSE
 965b:  41 87 62 4e             JE              G77,#62 [FALSE] 966b
 965f:  66 87 7f 4a             JIN             G77,G6f [FALSE] 966b
 9663:  e0 0f 83 33 9b 77 00    CALL            10666 (S201) -> -(SP)
 966a:  b8                      RET_POPPED      
 966b:  a0 87 7b                JZ              G77 [FALSE] 96a7
 966e:  b3 ...                  PRINT_RET       "Dental hygiene is highly recommended, but I'm not sure what you want to brush them with."
 96a7:  b2 ...                  PRINT           "A nice idea, but with a "
 96b6:  aa 87                   PRINT_OBJ       G77
 96b8:  b3 ...                  PRINT_RET       "?"

Routine 96bc, 0 locals ()

 96bd:  41 10 dc 59             JE              G00,#dc [FALSE] 96d8
 96c1:  41 88 3c 40             JE              G78,#3c [FALSE] RFALSE
 96c5:  b3 ...                  PRINT_RET       "The west wall is solid granite here."
 96d8:  41 10 be 59             JE              G00,#be [FALSE] 96f3
 96dc:  41 88 3c 40             JE              G78,#3c [FALSE] RFALSE
 96e0:  b3 ...                  PRINT_RET       "The east wall is solid granite here."
 96f3:  41 10 0f 70             JE              G00,#0f [FALSE] 9725
 96f7:  c1 97 88 53 3c 5b       JE              G78,#53,#3c [FALSE] 9716
 96fd:  b3 ...                  PRINT_RET       "It only SAYS "Granite Wall"."
 9716:  b3 ...                  PRINT_RET       "The wall isn't granite."
 9725:  b3 ...                  PRINT_RET       "There is no granite wall here."

Routine 9734, 0 locals ()

 9735:  c1 97 88 5d 3c 59       JE              G78,#5d,#3c [FALSE] 9752
 973b:  b3 ...                  PRINT_RET       "The songbird is not here but is probably nearby."
 9752:  41 88 4d 55             JE              G78,#4d [FALSE] 9769
 9756:  b3 ...                  PRINT_RET       "You can't hear the songbird now."
 9769:  41 88 3d 4f             JE              G78,#3d [FALSE] 977a
 976d:  b3 ...                  PRINT_RET       "It can't be followed."
 977a:  b3 ...                  PRINT_RET       "You can't see any songbird here."

Routine 978e, 0 locals ()

 978f:  c1 95 10 cb c1 c9 62    JE              G00,#cb,#c1,#c9 [FALSE] 97b6
 9796:  41 88 3c 53             JE              G78,#3c [FALSE] 97ab
 979a:  b3 ...                  PRINT_RET       "Why not find your brains?"
 97ab:  41 88 8b 40             JE              G78,#8b [FALSE] RFALSE
 97af:  e0 2f 4a 17 98 00       CALL            942e (G88) -> -(SP)
 97b5:  b0                      RTRUE           
 97b6:  c1 97 10 4f b4 80 44    JE              G00,#4f,#b4 [TRUE] 97ff
 97bd:  c1 97 10 51 50 80 3d    JE              G00,#51,#50 [TRUE] 97ff
 97c4:  41 88 3c 6c             JE              G78,#3c [FALSE] 97f2
 97c8:  41 10 4a 4f             JE              G00,#4a [FALSE] 97d9
 97cc:  b3 ...                  PRINT_RET       "It seems to be to the west."
 97d9:  b3 ...                  PRINT_RET       "It was here just a minute ago...."
 97f2:  b3 ...                  PRINT_RET       "You're not at the house."
 97ff:  41 88 3c 5f             JE              G78,#3c [FALSE] 9820
 9803:  b3 ...                  PRINT_RET       "It's right here! Are you blind or something?"
 9820:  41 88 8b 49             JE              G78,#8b [FALSE] 982b
 9824:  e0 2f 4a 17 9a 00       CALL            942e (G8a) -> -(SP)
 982a:  b0                      RTRUE           
 982b:  41 88 38 00 4d          JE              G78,#38 [FALSE] 987b
 9830:  b3 ...                  PRINT_RET       "The house is a beautiful colonial house which is painted white. It is clear that the owners must have been extremely wealthy."
 987b:  c1 97 88 2b 22 77       JE              G78,#2b,#22 [FALSE] 98b6
 9881:  41 10 4f 60             JE              G00,#4f [FALSE] 98a3
 9885:  0a eb 0b 49             TEST_ATTR       "kitchen window",#0b [FALSE] 9890
 9889:  e0 1f 49 5b cb 00       CALL            92b6 (#cb) -> -(SP)
 988f:  b8                      RET_POPPED      
 9890:  b2 ...                  PRINT           "The window is closed."
 989b:  bb                      NEW_LINE        
 989c:  e0 1f 4a 98 eb 00       CALL            9530 (#eb) -> -(SP)
 98a2:  b8                      RET_POPPED      
 98a3:  b3 ...                  PRINT_RET       "I can't see how to get in from here."
 98b6:  41 88 1c 40             JE              G78,#1c [FALSE] RFALSE
 98ba:  b3 ...                  PRINT_RET       "You must be joking."

Routine 98c8, 0 locals ()

 98c9:  41 88 8b 49             JE              G78,#8b [FALSE] 98d4
 98cd:  e0 2f 4a 17 99 00       CALL            942e (G89) -> -(SP)
 98d3:  b8                      RET_POPPED      
 98d4:  41 88 2d 59             JE              G78,#2d [FALSE] 98ef
 98d8:  b3 ...                  PRINT_RET       "You will have to specify a direction."
 98ef:  41 88 3c 57             JE              G78,#3c [FALSE] 9908
 98f3:  b3 ...                  PRINT_RET       "You cannot see the forest for the trees."
 9908:  41 88 4d 40             JE              G78,#4d [FALSE] RFALSE
 990c:  b3 ...                  PRINT_RET       "The pines and the hemlocks seem to be murmuring."

Routine 992a, 0 locals ()

 992b:  c1 95 88 20 1f 1e 40    JE              G78,#20,#1f,#1e [FALSE] RFALSE
 9932:  b3 ...                  PRINT_RET       "Don't you believe me? The mountains are impassable!"

Routine 9956, 3 locals (0000, 0000, 0000)

 995d:  41 88 40 c0             JE              G78,#40 [TRUE] RFALSE
 9961:  41 88 22 4c             JE              G78,#22 [FALSE] 996f
 9965:  e0 2f 27 36 47 00       CALL            4e6c (G37) -> -(SP)
 996b:  ad 00                   PRINT_PADDR     (SP)+
 996d:  bb                      NEW_LINE        
 996e:  b0                      RTRUE           
 996f:  41 88 3b 54             JE              G78,#3b [FALSE] 9985
 9973:  2d 02 87                STORE           L01,G77
 9976:  0d 88 12                STORE           G78,#12
 9979:  2d 87 86                STORE           G77,G76
 997c:  2d 86 02                STORE           G76,L01
 997f:  0d 03 00                STORE           L02,#00
 9982:  8c 00 1c                JUMP            999f
 9985:  41 86 ee c6             JE              G76,#ee [TRUE] 998d
 9989:  41 86 ed 4b             JE              G76,#ed [FALSE] 9996
 998d:  2d 02 86                STORE           L01,G76
 9990:  0d 03 00                STORE           L02,#00
 9993:  8c 00 0b                JUMP            999f
 9996:  2d 02 87                STORE           L01,G77
 9999:  a0 02 c5                JZ              L01 [TRUE] 999f
 999c:  0d 03 01                STORE           L02,#01
 999f:  41 02 ee 51             JE              L01,#ee [FALSE] 99b2
 99a3:  0d 02 ed                STORE           L01,#ed
 99a6:  c1 97 88 12 5d 48       JE              G78,#12,#5d [FALSE] 99b2
 99ac:  e0 2f 3c 5d 02 00       CALL            78ba (L01) -> -(SP)
 99b2:  a0 03 c8                JZ              L02 [TRUE] 99bb
 99b5:  2d 87 02                STORE           G77,L01
 99b8:  8c 00 05                JUMP            99be
 99bb:  2d 86 02                STORE           G76,L01
 99be:  a3 7f 01                GET_PARENT      G6f -> L00
 99c1:  4a 01 1b c5             TEST_ATTR       L00,#1b [TRUE] 99c8
 99c5:  0d 01 00                STORE           L00,#00
 99c8:  c1 97 88 12 5d 00 f4    JE              G78,#12,#5d [FALSE] 9ac1
 99cf:  a0 03 00 f0             JZ              L02 [FALSE] 9ac1
 99d3:  a0 01 f4                JZ              L00 [TRUE] 9a08
 99d6:  61 01 87 c9             JE              L00,G77 [TRUE] 99e1
 99da:  a0 87 6d                JZ              G77 [FALSE] 9a08
 99dd:  66 02 01 e9             JIN             L01,L00 [TRUE] 9a08
 99e1:  b2 ...                  PRINT           "There is now a puddle in the bottom of the "
 99f8:  aa 01                   PRINT_OBJ       L00
 99fa:  b2 ...                  PRINT           "."
 99fd:  bb                      NEW_LINE        
 99fe:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 9a04:  6e 86 01                INSERT_OBJ      G76,L00
 9a07:  b0                      RTRUE           
 9a08:  a0 87 f0                JZ              G77 [TRUE] 9a39
 9a0b:  41 87 ec ec             JE              G77,#ec [TRUE] 9a39
 9a0f:  b2 ...                  PRINT           "The water leaks out of the "
 9a1c:  aa 87                   PRINT_OBJ       G77
 9a1e:  b2 ...                  PRINT           " and evaporates immediately."
 9a31:  bb                      NEW_LINE        
 9a32:  e0 2f 3c 5d 02 00       CALL            78ba (L01) -> -(SP)
 9a38:  b8                      RET_POPPED      
 9a39:  26 ec 7f 00 46          JIN             "glass bottle",G6f [FALSE] 9a82
 9a3e:  0a ec 0b d5             TEST_ATTR       "glass bottle",#0b [TRUE] 9a55
 9a42:  b2 ...                  PRINT           "The bottle is closed."
 9a4d:  bb                      NEW_LINE        
 9a4e:  e0 1f 4a 98 ec 00       CALL            9530 (#ec) -> -(SP)
 9a54:  b8                      RET_POPPED      
 9a55:  92 ec 00 da             GET_CHILD       "glass bottle" -> -(SP) [TRUE] 9a71
 9a59:  0e ed ec                INSERT_OBJ      "quantity of water","glass bottle"
 9a5c:  b3 ...                  PRINT_RET       "The bottle is now full of water."
 9a71:  b3 ...                  PRINT_RET       "The water slips through your fingers."
 9a82:  46 86 ec 6c             JIN             G76,"glass bottle" [FALSE] 9ab0
 9a86:  41 88 5d 68             JE              G78,#5d [FALSE] 9ab0
 9a8a:  a0 87 65                JZ              G77 [FALSE] 9ab0
 9a8d:  b3 ...                  PRINT_RET       "It's in the bottle. Perhaps you should take that instead."
 9ab0:  b3 ...                  PRINT_RET       "The water slips through your fingers."
 9ac1:  a0 03 cb                JZ              L02 [TRUE] 9acd
 9ac4:  b3 ...                  PRINT_RET       "Nice try."
 9acd:  c1 97 88 3f 31 00 55    JE              G78,#3f,#31 [FALSE] 9b27
 9ad4:  e0 1f 3c 5d ed 00       CALL            78ba (#ed) -> -(SP)
 9ada:  a0 01 e3                JZ              L00 [TRUE] 9afe
 9add:  b2 ...                  PRINT           "There is now a puddle in the bottom of the "
 9af4:  aa 01                   PRINT_OBJ       L00
 9af6:  b2 ...                  PRINT           "."
 9af9:  bb                      NEW_LINE        
 9afa:  2e ed 01                INSERT_OBJ      "quantity of water",L00
 9afd:  b0                      RTRUE           
 9afe:  b2 ...                  PRINT           "The water spills to the floor and evaporates immediately."
 9b1f:  bb                      NEW_LINE        
 9b20:  e0 1f 3c 5d ed 00       CALL            78ba (#ed) -> -(SP)
 9b26:  b8                      RET_POPPED      
 9b27:  41 88 7f 40             JE              G78,#7f [FALSE] RFALSE
 9b2b:  b2 ...                  PRINT           "The water splashes on the walls and evaporates immediately."
 9b4e:  bb                      NEW_LINE        
 9b4f:  e0 1f 3c 5d ed 00       CALL            78ba (#ed) -> -(SP)
 9b55:  b8                      RET_POPPED      

Routine 9b56, 0 locals ()

 9b57:  c1 97 88 23 2b 50       JE              G78,#23,#2b [FALSE] 9b6b
 9b5d:  0d 43 01                STORE           G33,#01
 9b60:  e0 10 4a fd eb 9b a8 9b bd 00 
                               CALL            95fa (#eb,S202,S203) -> -(SP)
 9b6a:  b8                      RET_POPPED      
 9b6b:  41 88 38 6a             JE              G78,#38 [FALSE] 9b97
 9b6f:  a0 43 67                JZ              G33 [FALSE] 9b97
 9b72:  b3 ...                  PRINT_RET       "The window is slightly ajar, but not enough to allow entry."
 9b97:  c1 95 88 22 19 89 54    JE              G78,#22,#19,#89 [FALSE] 9bb0
 9b9e:  41 10 cb 49             JE              G00,#cb [FALSE] 9ba9
 9ba2:  e0 1f 4a 38 1e 00       CALL            9470 (#1e) -> -(SP)
 9ba8:  b0                      RTRUE           
 9ba9:  e0 1f 4a 38 1d 00       CALL            9470 (#1d) -> -(SP)
 9baf:  b0                      RTRUE           
 9bb0:  41 88 39 40             JE              G78,#39 [FALSE] RFALSE
 9bb4:  b2 ...                  PRINT           "You can see "
 9bbb:  41 10 cb 59             JE              G00,#cb [FALSE] 9bd6
 9bbf:  b3 ...                  PRINT_RET       "a clear area leading towards a forest."
 9bd6:  b3 ...                  PRINT_RET       "what appears to be a kitchen."

Routine 9be8, 0 locals ()

 9be9:  41 88 6f 61             JE              G78,#6f [FALSE] 9c0c
 9bed:  b2 ...                  PRINT           "The spirits jeer loudly and ignore you."
 9c06:  bb                      NEW_LINE        
 9c07:  0d 7c 00                STORE           G6c,#00
 9c0a:  ab 7c                   RET             G6c
 9c0c:  41 88 3a 5d             JE              G78,#3a [FALSE] 9c2b
 9c10:  b3 ...                  PRINT_RET       "Only the ceremony itself has any effect."
 9c2b:  c1 97 88 2a 13 65       JE              G78,#2a,#13 [FALSE] 9c54
 9c31:  41 86 e9 61             JE              G76,#e9 [FALSE] 9c54
 9c35:  b3 ...                  PRINT_RET       "How can you attack a spirit with material objects?"
 9c54:  b3 ...                  PRINT_RET       "You seem unable to interact with these spirits."

Routine 9c72, 0 locals ()

 9c73:  41 88 69 79             JE              G78,#69 [FALSE] 9cae
 9c77:  a0 42 cc                JZ              G32 [TRUE] 9c84
 9c7a:  e0 2f 27 36 44 00       CALL            4e6c (G34) -> -(SP)
 9c80:  ad 00                   PRINT_PADDR     (SP)+
 9c82:  bb                      NEW_LINE        
 9c83:  b0                      RTRUE           
 9c84:  0e e3 e2                INSERT_OBJ      "basket","Shaft Room"
 9c87:  0e e5 e4                INSERT_OBJ      "basket","Drafty Room"
 9c8a:  0d 42 01                STORE           G32,#01
 9c8d:  e0 1f 4a 98 e3 00       CALL            9530 (#e3) -> -(SP)
 9c93:  b3 ...                  PRINT_RET       "The basket is raised to the top of the shaft."
 9cae:  41 88 54 00 59          JE              G78,#54 [FALSE] 9d0a
 9cb3:  a0 42 4c                JZ              G32 [FALSE] 9cc0
 9cb6:  e0 2f 27 36 44 00       CALL            4e6c (G34) -> -(SP)
 9cbc:  ad 00                   PRINT_PADDR     (SP)+
 9cbe:  bb                      NEW_LINE        
 9cbf:  b0                      RTRUE           
 9cc0:  0e e3 e4                INSERT_OBJ      "basket","Drafty Room"
 9cc3:  0e e5 e2                INSERT_OBJ      "basket","Shaft Room"
 9cc6:  e0 1f 4a 98 e5 00       CALL            9530 (#e5) -> -(SP)
 9ccc:  b2 ...                  PRINT           "The basket is lowered to the bottom of the shaft."
 9ce9:  bb                      NEW_LINE        
 9cea:  0d 42 00                STORE           G32,#00
 9ced:  a0 52 c1                JZ              G42 [TRUE] RTRUE
 9cf0:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 9cf6:  a0 52 41                JZ              G42 [FALSE] RTRUE
 9cf9:  b2 ...                  PRINT           "It is now pitch black."
 9d08:  bb                      NEW_LINE        
 9d09:  b0                      RTRUE           
 9d0a:  41 86 e5 c6             JE              G76,#e5 [TRUE] 9d12
 9d0e:  41 87 e5 59             JE              G77,#e5 [FALSE] 9d29
 9d12:  b3 ...                  PRINT_RET       "The basket is at the other end of the chain."
 9d29:  41 88 5d 40             JE              G78,#5d [FALSE] RFALSE
 9d2d:  c1 97 86 e3 e5 40       JE              G76,#e3,#e5 [FALSE] RFALSE
 9d33:  b3 ...                  PRINT_RET       "The cage is securely fastened to the iron chain."

Routine 9d50, 0 locals ()

 9d51:  41 88 6f 4d             JE              G78,#6f [FALSE] 9d60
 9d55:  e0 1f 4e eb 06 00       CALL            9dd6 (#06) -> -(SP)
 9d5b:  0d 7c 00                STORE           G6c,#00
 9d5e:  ab 7c                   RET             G6c
 9d60:  c1 95 88 2a 13 5d 40    JE              G78,#2a,#13,#5d [FALSE] RFALSE
 9d67:  93 bd 00                GET_PARENT      "clove of garlic" -> -(SP)
 9d6a:  c1 ab 00 7f 10 5d       JE              (SP)+,G6f,G00 [FALSE] 9d8b
 9d70:  b3 ...                  PRINT_RET       "You can't reach him; he's on the ceiling."
 9d8b:  e0 3f 4e c9 00          CALL            9d92 -> -(SP)
 9d90:  b8                      RET_POPPED      

Routine 9d92, 0 locals ()

 9d93:  e0 1f 4e eb 04 00       CALL            9dd6 (#04) -> -(SP)
 9d99:  bb                      NEW_LINE        
 9d9a:  b2 ...                  PRINT           "The bat grabs you by the scruff of your neck and lifts you away...."
 9dc1:  bb                      NEW_LINE        
 9dc2:  bb                      NEW_LINE        
 9dc3:  e0 2f 27 36 41 00       CALL            4e6c (G31) -> -(SP)
 9dc9:  e0 27 49 5b 00 00 00    CALL            92b6 ((SP)+,#00) -> -(SP)
 9dd0:  e0 3f 46 44 00          CALL            8c88 -> -(SP)
 9dd5:  b0                      RTRUE           

Routine 9dd6, 1 local (0000)

 9dd9:  04 01 01 45             DEC_CHK         L00,#01 [FALSE] 9de0
 9ddd:  8c 00 0f                JUMP            9ded
 9de0:  b2 ...                  PRINT           "    Fweep!"
 9de9:  bb                      NEW_LINE        
 9dea:  8c ff ee                JUMP            9dd9
 9ded:  bb                      NEW_LINE        
 9dee:  b0                      RTRUE           

Routine 9df0, 0 locals ()

 9df1:  41 88 6d 40             JE              G78,#6d [FALSE] RFALSE
 9df5:  c1 8f 10 5a 7f 45       JE              G00,#5a7f [FALSE] 9dfe
 9dfb:  a0 a1 c0                JZ              G91 [TRUE] RFALSE
 9dfe:  b3 ...                  PRINT_RET       "Ding, dong."

Routine 9e0a, 0 locals ()

 9e0b:  41 88 5d 59             JE              G78,#5d [FALSE] 9e26
 9e0f:  b3 ...                  PRINT_RET       "The bell is very hot and cannot be taken."
 9e26:  41 88 6e cb             JE              G78,#6e [TRUE] 9e33
 9e2a:  41 88 6d 00 50          JE              G78,#6d [FALSE] 9e7d
 9e2f:  a0 87 80 4c             JZ              G77 [TRUE] 9e7d
 9e33:  4a 87 1a 5e             TEST_ATTR       G77,#1a [FALSE] 9e53
 9e37:  b2 ...                  PRINT           "The "
 9e3a:  aa 87                   PRINT_OBJ       G77
 9e3c:  b2 ...                  PRINT           " burns and is consumed."
 9e4b:  bb                      NEW_LINE        
 9e4c:  e0 2f 3c 5d 87 00       CALL            78ba (G77) -> -(SP)
 9e52:  b8                      RET_POPPED      
 9e53:  41 87 01 53             JE              G77,#01 [FALSE] 9e68
 9e57:  b3 ...                  PRINT_RET       "The bell is too hot to touch."
 9e68:  b3 ...                  PRINT_RET       "The heat from the bell is too intense."
 9e7d:  41 88 61 6e             JE              G78,#61 [FALSE] 9ead
 9e81:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 9e87:  b2 ...                  PRINT           "The water cools the bell and is evaporated."
 9e9e:  bb                      NEW_LINE        
 9e9f:  e0 07 2a 39 5c 72 00 00 CALL            5472 (#5c72,#00) -> -(SP)
 9ea7:  e0 3f 5c 72 00          CALL            b8e4 -> -(SP)
 9eac:  b8                      RET_POPPED      
 9ead:  41 88 6d 40             JE              G78,#6d [FALSE] RFALSE
 9eb1:  b3 ...                  PRINT_RET       "The bell is too hot to reach."

Routine 9ec2, 0 locals ()

 9ec3:  41 88 2b 5b             JE              G78,#2b [FALSE] 9ee0
 9ec7:  b3 ...                  PRINT_RET       "The windows are boarded and can't be opened."
 9ee0:  41 88 2a 40             JE              G78,#2a [FALSE] RFALSE
 9ee4:  b3 ...                  PRINT_RET       "You can't break the windows open."

Routine 9ef8, 0 locals ()

 9ef9:  41 88 5d 40             JE              G78,#5d [FALSE] RFALSE
 9efd:  b3 ...                  PRINT_RET       "The nails, deeply imbedded in the door, cannot be removed."

Routine 9f1e, 0 locals ()

 9f1f:  41 88 22 40             JE              G78,#22 [FALSE] RFALSE
 9f23:  b3 ...                  PRINT_RET       "You can't fit through the crack."

Routine 9f30, 1 local (0000)

 9f33:  41 01 03 00 93          JE              L00,#03 [FALSE] 9fc9
 9f38:  b2 ...                  PRINT           "You are in the kitchen of the white house. A table seems to have been used recently for the preparation of food. A passage leads to the west and a dark staircase can be seen leading upward. A dark chimney leads down and to the east is a small window which is "
 9fb5:  0a eb 0b 47             TEST_ATTR       "kitchen window",#0b [FALSE] 9fbe
 9fb9:  b3 ...                  PRINT_RET       "open."
 9fbe:  b3 ...                  PRINT_RET       "slightly ajar."
 9fc9:  41 01 01 40             JE              L00,#01 [FALSE] RFALSE
 9fcd:  41 88 1e 4d             JE              G78,#1e [FALSE] 9fdc
 9fd1:  41 86 49 49             JE              G76,#49 [FALSE] 9fdc
 9fd5:  e0 1f 4a 38 17 00       CALL            9470 (#17) -> -(SP)
 9fdb:  b8                      RET_POPPED      
 9fdc:  41 88 1e 40             JE              G78,#1e [FALSE] RFALSE
 9fe0:  41 86 49 40             JE              G76,#49 [FALSE] RFALSE
 9fe4:  b3 ...                  PRINT_RET       "There are no stairs leading down."

Routine 9ff6, 1 local (0000)

 9ff9:  41 01 01 40             JE              L00,#01 [FALSE] RFALSE
 9ffd:  41 88 36 d4             JE              G78,#36 [TRUE] a013
 a001:  41 88 89 48             JE              G78,#89 [FALSE] a00b
 a005:  c1 97 86 1d 15 ca       JE              G76,#1d,#15 [TRUE] a013
 a00b:  41 88 22 40             JE              G78,#22 [FALSE] RFALSE
 a00f:  41 86 b1 40             JE              G76,#b1 [FALSE] RFALSE
 a013:  b2 ...                  PRINT           "Inside the Barrow
As you enter the barrow, the door closes inexorably behind you. Around you it is dark, but ahead is an enormous cavern, brightly lit. Through its center runs a wide stream. Spanning the stream is a small wooden footbridge, and beyond a path leads into a dark tunnel. Above the bridge, floating in the air, is a large sign. It reads:  All ye who stand before this bridge have completed a great and perilous adventure which has tested your wit and courage. You have mastered"
 a12e:  10 00 01 00             LOADB           #00,#01 -> -(SP)
 a132:  49 00 08 00             AND             (SP)+,#08 -> -(SP)
 a136:  a0 00 00 c9             JZ              (SP)+ [FALSE] a201
 a13a:  b2 ...                  PRINT           " the first part of the ZORK trilogy. Those who pass over this bridge must be prepared to undertake an even greater adventure that will severely test your skill and bravery!

The ZORK trilogy continues with "ZORK II: The Wizard of Frobozz" and is completed in "ZORK III: The Dungeon Master.""
 a1fd:  bb                      NEW_LINE        
 a1fe:  8c 00 20                JUMP            a21f
 a201:  b2 ...                  PRINT           " ZORK: The Great Underground Empire.
"
 a21e:  bb                      NEW_LINE        
 a21f:  e0 1f 36 e6 00 00       CALL            6dcc (#00) -> -(SP)
 a225:  b8                      RET_POPPED      

Routine a226, 0 locals ()

 a227:  c1 97 88 23 2b 40       JE              G78,#23,#2b [FALSE] RFALSE
 a22d:  b3 ...                  PRINT_RET       "The door is too heavy."

Routine a238, 0 locals ()

 a239:  41 88 22 40             JE              G78,#22 [FALSE] RFALSE
 a23d:  e0 1f 4a 38 1d 00       CALL            9470 (#1d) -> -(SP)
 a243:  b8                      RET_POPPED      

Routine a244, 0 locals ()

 a245:  41 88 5d 40             JE              G78,#5d [FALSE] RFALSE
 a249:  41 86 c2 40             JE              G76,#c2 [FALSE] RFALSE
 a24d:  b3 ...                  PRINT_RET       "The trophy case is securely fastened to the wall."

Routine a26c, 3 locals (0000, 0000, 0000)

 a273:  41 01 03 01 1f          JE              L00,#03 [FALSE] a395
 a278:  b2 ...                  PRINT           "You are in the living room. There is a doorway to the east"
 a295:  a0 9f 80 4a             JZ              G8f [TRUE] a2e1
 a299:  b2 ...                  PRINT           ". To the west is a cyclops-shaped opening in an old wooden door, above which is some strange gothic lettering, "
 a2de:  8c 00 33                JUMP            a312
 a2e1:  b2 ...                  PRINT           ", a wooden door with strange gothic lettering to the west, which appears to be nailed shut, "
 a312:  b2 ...                  PRINT           "a trophy case, "
 a31d:  2d 02 40                STORE           L01,G30
 a320:  a0 02 e4                JZ              L01 [TRUE] a345
 a323:  0a b7 0b 60             TEST_ATTR       "trap door",#0b [FALSE] a345
 a327:  b2 ...                  PRINT           "and a rug lying beside an open trap door."
 a342:  8c 00 50                JUMP            a393
 a345:  a0 02 d8                JZ              L01 [TRUE] a35e
 a348:  b2 ...                  PRINT           "and a closed trap door at your feet."
 a35b:  8c 00 37                JUMP            a393
 a35e:  0a b7 0b 58             TEST_ATTR       "trap door",#0b [FALSE] a378
 a362:  b2 ...                  PRINT           "and an open trap door at your feet."
 a375:  8c 00 1d                JUMP            a393
 a378:  b2 ...                  PRINT           "and a large oriental rug in the center of the room."
 a393:  bb                      NEW_LINE        
 a394:  b0                      RTRUE           
 a395:  41 01 06 40             JE              L00,#06 [FALSE] RFALSE
 a399:  41 88 5d ca             JE              G78,#5d [TRUE] a3a5
 a39d:  41 88 12 40             JE              G78,#12 [FALSE] RFALSE
 a3a1:  41 87 c2 40             JE              G77,#c2 [FALSE] RFALSE
 a3a5:  46 86 c2 48             JIN             G76,"trophy case" [FALSE] a3af
 a3a9:  e0 2f 51 e0 86 00       CALL            a3c0 (G76) -> -(SP)
 a3af:  e0 3f 51 f0 00          CALL            a3e0 -> -(SP)
 a3b4:  74 4f 00 11             ADD             G3f,(SP)+ -> G01
 a3b8:  e0 1f 48 31 00 00       CALL            9062 (#00) -> -(SP)
 a3be:  b1                      RFALSE          

Routine a3c0, 2 locals (0000, 0000)

 a3c5:  a2 01 02 c2             GET_CHILD       L00 -> L01 [TRUE] a3c9
 a3c9:  a0 02 c1                JZ              L01 [TRUE] RTRUE
 a3cc:  4b 02 03                SET_ATTR        L01,#03
 a3cf:  a2 02 00 48             GET_CHILD       L01 -> -(SP) [FALSE] a3d9
 a3d3:  e0 2f 51 e0 02 00       CALL            a3c0 (L01) -> -(SP)
 a3d9:  a1 02 02 c2             GET_SIBLING     L01 -> L01 [TRUE] a3dd
 a3dd:  8c ff eb                JUMP            a3c9

Routine a3e0, 3 locals (00c2, 0000, 0000)

 a3e7:  a2 01 02 c2             GET_CHILD       L00 -> L01 [TRUE] a3eb
 a3eb:  a0 02 44                JZ              L01 [FALSE] a3f0
 a3ee:  ab 03                   RET             L02
 a3f0:  51 02 0c 00             GET_PROP        L01,#0c -> -(SP)
 a3f4:  74 03 00 03             ADD             L02,(SP)+ -> L02
 a3f8:  a2 02 00 48             GET_CHILD       L01 -> -(SP) [FALSE] a402
 a3fc:  e0 2f 51 f0 02 00       CALL            a3e0 (L01) -> -(SP)
 a402:  a1 02 02 c2             GET_SIBLING     L01 -> L01 [TRUE] a406
 a406:  8c ff e4                JUMP            a3eb

Routine a40a, 0 locals ()

 a40b:  41 88 69 4a             JE              G78,#69 [FALSE] a417
 a40f:  e0 17 2b be 2b b7 00    CALL            577c (#2b,#b7) -> -(SP)
 a416:  b0                      RTRUE           
 a417:  c1 97 88 23 2b 51       JE              G78,#23,#2b [FALSE] a42c
 a41d:  41 10 c1 4d             JE              G00,#c1 [FALSE] a42c
 a421:  e0 20 4a fd 86 9b cd 9b e3 00 
                               CALL            95fa (G76,S204,S205) -> -(SP)
 a42b:  b8                      RET_POPPED      
 a42c:  41 88 51 6c             JE              G78,#51 [FALSE] a45a
 a430:  41 10 c1 68             JE              G00,#c1 [FALSE] a45a
 a434:  0a b7 0b 5f             TEST_ATTR       "trap door",#0b [FALSE] a455
 a438:  b3 ...                  PRINT_RET       "You see a rickety staircase descending into darkness."
 a455:  b3 ...                  PRINT_RET       "It's closed."
 a45a:  41 10 48 40             JE              G00,#48 [FALSE] RFALSE
 a45e:  c1 97 88 85 2b 57       JE              G78,#85,#2b [FALSE] a479
 a464:  0a b7 0b d3             TEST_ATTR       "trap door",#0b [TRUE] a479
 a468:  b3 ...                  PRINT_RET       "The door is locked from above."
 a479:  41 88 23 5b             JE              G78,#23 [FALSE] a496
 a47d:  0a b7 0b d7             TEST_ATTR       "trap door",#0b [TRUE] a496
 a481:  0c b7 03                CLEAR_ATTR      "trap door",#03
 a484:  0c b7 0b                CLEAR_ATTR      "trap door",#0b
 a487:  b3 ...                  PRINT_RET       "The door closes and locks."
 a496:  c1 97 88 23 2b 40       JE              G78,#23,#2b [FALSE] RFALSE
 a49c:  e0 2f 27 36 44 00       CALL            4e6c (G34) -> -(SP)
 a4a2:  ad 00                   PRINT_PADDR     (SP)+
 a4a4:  bb                      NEW_LINE        
 a4a5:  b0                      RTRUE           

Routine a4a6, 1 local (0000)

 a4a9:  41 01 03 00 5d          JE              L00,#03 [FALSE] a509
 a4ae:  b3 ...                  PRINT_RET       "You are in a dark and damp cellar with a narrow passageway leading north, and a crawlway to the south. On the west is the bottom of a steep metal ramp which is unclimbable."
 a509:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
 a50d:  0a b7 0b 40             TEST_ATTR       "trap door",#0b [FALSE] RFALSE
 a511:  0a b7 03 c0             TEST_ATTR       "trap door",#03 [TRUE] RFALSE
 a515:  0c b7 0b                CLEAR_ATTR      "trap door",#0b
 a518:  0b b7 03                SET_ATTR        "trap door",#03
 a51b:  b2 ...                  PRINT           "The trap door crashes shut, and you hear someone barring it."
 a540:  bb                      NEW_LINE        
 a541:  bb                      NEW_LINE        
 a542:  b0                      RTRUE           

Routine a544, 0 locals ()

 a545:  41 88 38 40             JE              G78,#38 [FALSE] RFALSE
 a549:  b2 ...                  PRINT           "The chimney leads "
 a556:  41 10 cb 4a             JE              G00,#cb [FALSE] a562
 a55a:  b2 ...                  PRINT           "down"
 a55f:  8c 00 05                JUMP            a565
 a562:  b2 ...                  PRINT           "up"
 a565:  b3 ...                  PRINT_RET       "ward, and looks climbable."

Routine a578, 1 local (0000)

 a57b:  a2 7f 01 df             GET_CHILD       G6f -> L00 [TRUE] a59c
 a57f:  b2 ...                  PRINT           "Going up empty-handed is a bad idea."
 a59a:  bb                      NEW_LINE        
 a59b:  b1                      RFALSE          
 a59c:  a1 01 01 46             GET_SIBLING     L00 -> L00 [FALSE] a5a4
 a5a0:  a1 01 00 d1             GET_SIBLING     L00 -> -(SP) [TRUE] a5b3
 a5a4:  26 a4 7f 4d             JIN             "brass lantern",G6f [FALSE] a5b3
 a5a8:  0a b7 0b c7             TEST_ATTR       "trap door",#0b [TRUE] a5b1
 a5ac:  0c b7 03                CLEAR_ATTR      "trap door",#03
 a5af:  9b cb                   RET             #cb
 a5b1:  9b cb                   RET             #cb
 a5b3:  b2 ...                  PRINT           "You can't get up there with what you're carrying."
 a5ce:  bb                      NEW_LINE        
 a5cf:  b1                      RFALSE          

Routine a5d0, 0 locals ()

 a5d1:  a0 40 db                JZ              G30 [TRUE] a5ed
 a5d4:  0a b7 0b 44             TEST_ATTR       "trap door",#0b [FALSE] a5da
 a5d8:  9b 48                   RET             #48
 a5da:  b2 ...                  PRINT           "The trap door is closed."
 a5e5:  bb                      NEW_LINE        
 a5e6:  e0 1f 4a 98 b7 00       CALL            9530 (#b7) -> -(SP)
 a5ec:  b1                      RFALSE          
 a5ed:  b2 ...                  PRINT           "You can't go that way."
 a5f8:  bb                      NEW_LINE        
 a5f9:  b1                      RFALSE          

Routine a5fa, 0 locals ()

 a5fb:  41 88 69 00 44          JE              G78,#69 [FALSE] a642
 a600:  b2 ...                  PRINT           "The rug is too heavy to lift"
 a611:  a0 40 c5                JZ              G30 [TRUE] a617
 a614:  b3 ...                  PRINT_RET       "."
 a617:  b3 ...                  PRINT_RET       ", but in trying to take it you have noticed an irregularity beneath it."
 a642:  c1 97 88 65 58 00 80    JE              G78,#65,#58 [FALSE] a6c7
 a649:  a0 40 ed                JZ              G30 [TRUE] a677
 a64c:  b3 ...                  PRINT_RET       "Having moved the carpet previously, you find it impossible to move it again."
 a677:  b2 ...                  PRINT           "With a great effort, the rug is moved to one side of the room, revealing the dusty cover of a closed trap door."
 a6b8:  bb                      NEW_LINE        
 a6b9:  0c b7 07                CLEAR_ATTR      "trap door",#07
 a6bc:  e0 1f 4a 98 b7 00       CALL            9530 (#b7) -> -(SP)
 a6c2:  0d 40 01                STORE           G30,#01
 a6c5:  ab 40                   RET             G30
 a6c7:  41 88 5d 5d             JE              G78,#5d [FALSE] a6e6
 a6cb:  b3 ...                  PRINT_RET       "The rug is extremely heavy and cannot be carried."
 a6e6:  41 88 51 00 52          JE              G78,#51 [FALSE] a73b
 a6eb:  a0 40 00 4e             JZ              G30 [FALSE] a73b
 a6ef:  0a b7 0b 80 49          TEST_ATTR       "trap door",#0b [TRUE] a73b
 a6f4:  b3 ...                  PRINT_RET       "Underneath the rug is a closed trap door. As you drop the corner of the rug, the trap door is once again concealed from view."
 a73b:  41 88 21 40             JE              G78,#21 [FALSE] RFALSE
 a73f:  a0 40 00 48             JZ              G30 [FALSE] a789
 a743:  0a b7 0b 80 43          TEST_ATTR       "trap door",#0b [TRUE] a789
 a748:  b3 ...                  PRINT_RET       "As you sit, you notice an irregularity underneath it. Rather than be uncomfortable, you stand up again."
 a789:  b3 ...                  PRINT_RET       "I suppose you think it's a magic carpet?"

Routine a7a2, 0 locals ()

 a7a3:  a0 9d 40                JZ              G8d [FALSE] RFALSE
 a7a6:  e0 17 53 dc da d9 00    CALL            a7b8 (#da,#d9) -> -(SP)
 a7ad:  b8                      RET_POPPED      

Routine a7ae, 0 locals ()

 a7af:  e0 17 53 dc 71 72 00    CALL            a7b8 (#71,#72) -> -(SP)
 a7b6:  b8                      RET_POPPED      

Routine a7b8, 2 locals (0000, 0000)

 a7bd:  66 02 10 40             JIN             L01,G00 [FALSE] RFALSE
 a7c1:  41 88 5d 40             JE              G78,#5d [FALSE] RFALSE
 a7c5:  66 01 02 58             JIN             L00,L01 [FALSE] a7df
 a7c9:  b2 ...                  PRINT           "The "
 a7cc:  aa 02                   PRINT_OBJ       L01
 a7ce:  b3 ...                  PRINT_RET       " swings it out of your reach."
 a7df:  b2 ...                  PRINT           "The "
 a7e2:  aa 01                   PRINT_OBJ       L00
 a7e4:  b2 ...                  PRINT           " seems white-hot. You can't hold on to it."
 a7fb:  bb                      NEW_LINE        
 a7fc:  b0                      RTRUE           

Routine a7fe, 1 local (0000)

 a801:  41 88 6f 63             JE              G78,#6f [FALSE] a826
 a805:  b2 ...                  PRINT           "The troll isn't much of a conversationalist."
 a820:  bb                      NEW_LINE        
 a821:  0d 7c 00                STORE           G6c,#00
 a824:  ab 7c                   RET             G6c
 a826:  41 01 01 00 a2          JE              L00,#01 [FALSE] a8cb
 a82b:  06 da d9 c0             JIN             "bloody axe","troll" [TRUE] RFALSE
 a82f:  26 da 10 00 56          JIN             "bloody axe",G00 [FALSE] a888
 a834:  e0 1f 27 21 4b 00       CALL            4e42 (#4b) -> -(SP)
 a83a:  a0 00 80 4c             JZ              (SP)+ [TRUE] a888
 a83e:  0b da 0e                SET_ATTR        "bloody axe",#0e
 a841:  0c da 1d                CLEAR_ATTR      "bloody axe",#1d
 a844:  0e da d9                INSERT_OBJ      "bloody axe","troll"
 a847:  e3 53 d9 0b 9b ec       PUT_PROP        "troll",#0b,S206
 a84d:  26 d9 10 41             JIN             "troll",G00 [FALSE] RTRUE
 a851:  b3 ...                  PRINT_RET       "The troll, angered and humiliated, recovers his weapon. He appears to have an axe to grind with you."
 a888:  26 d9 10 40             JIN             "troll",G00 [FALSE] RFALSE
 a88c:  e3 53 d9 0b 9c 03       PUT_PROP        "troll",#0b,S207
 a892:  b2 ...                  PRINT           "The troll, disarmed, cowers in terror, pleading for his life in the guttural tongue of the trolls."
 a8c9:  bb                      NEW_LINE        
 a8ca:  b0                      RTRUE           
 a8cb:  41 01 02 54             JE              L00,#02 [FALSE] a8e1
 a8cf:  06 da d9 4b             JIN             "bloody axe","troll" [FALSE] a8dc
 a8d3:  2e da 10                INSERT_OBJ      "bloody axe",G00
 a8d6:  0c da 0e                CLEAR_ATTR      "bloody axe",#0e
 a8d9:  0b da 1d                SET_ATTR        "bloody axe",#1d
 a8dc:  0d 9d 01                STORE           G8d,#01
 a8df:  ab 9d                   RET             G8d
 a8e1:  41 01 03 5d             JE              L00,#03 [FALSE] a900
 a8e5:  0c d9 02                CLEAR_ATTR      "troll",#02
 a8e8:  06 da d9 4b             JIN             "bloody axe","troll" [FALSE] a8f5
 a8ec:  2e da 10                INSERT_OBJ      "bloody axe",G00
 a8ef:  0c da 0e                CLEAR_ATTR      "bloody axe",#0e
 a8f2:  0b da 1d                SET_ATTR        "bloody axe",#1d
 a8f5:  e3 53 d9 0b 9c 0e       PUT_PROP        "troll",#0b,S208
 a8fb:  0d 9d 01                STORE           G8d,#01
 a8fe:  ab 9d                   RET             G8d
 a900:  41 01 04 00 59          JE              L00,#04 [FALSE] a95c
 a905:  26 d9 10 67             JIN             "troll",G00 [FALSE] a92e
 a909:  0b d9 02                SET_ATTR        "troll",#02
 a90c:  b2 ...                  PRINT           "The troll stirs, quickly resuming a fighting stance."
 a92d:  bb                      NEW_LINE        
 a92e:  06 da d9 4b             JIN             "bloody axe","troll" [FALSE] a93b
 a932:  e3 53 d9 0b 9c 24       PUT_PROP        "troll",#0b,S209
 a938:  8c 00 1e                JUMP            a957
 a93b:  06 da 66 54             JIN             "bloody axe","The Troll Room" [FALSE] a951
 a93f:  0b da 0e                SET_ATTR        "bloody axe",#0e
 a942:  0c da 1d                CLEAR_ATTR      "bloody axe",#1d
 a945:  0e da d9                INSERT_OBJ      "bloody axe","troll"
 a948:  e3 53 d9 0b 9c 24       PUT_PROP        "troll",#0b,S209
 a94e:  8c 00 08                JUMP            a957
 a951:  e3 53 d9 0b 9c 3b       PUT_PROP        "troll",#0b,S210
 a957:  0d 9d 00                STORE           G8d,#00
 a95a:  ab 9d                   RET             G8d
 a95c:  41 01 05 51             JE              L00,#05 [FALSE] a96f
 a960:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 a964:  23 21 00 40             JG              #21,(SP)+ [FALSE] RFALSE
 a968:  0b d9 02                SET_ATTR        "troll",#02
 a96b:  0d 7c 00                STORE           G6c,#00
 a96e:  b0                      RTRUE           
 a96f:  a0 01 40                JZ              L00 [FALSE] RFALSE
 a972:  41 88 38 4a             JE              G78,#38 [FALSE] a97e
 a976:  11 d9 0b 00             GET_PROP        "troll",#0b -> -(SP)
 a97a:  ad 00                   PRINT_PADDR     (SP)+
 a97c:  bb                      NEW_LINE        
 a97d:  b0                      RTRUE           
 a97e:  c1 97 88 3f 7f 49       JE              G78,#3f,#7f [FALSE] a98b
 a984:  a0 86 c6                JZ              G76 [TRUE] a98b
 a987:  41 87 d9 ca             JE              G77,#d9 [TRUE] a993
 a98b:  c1 95 88 2a 58 5d 02 23 JE              G78,#2a,#58,#5d [FALSE] abb4
 a993:  e0 1f 80 6c d9 00       CALL            100d8 (#d9) -> -(SP)
 a999:  c1 97 88 3f 7f 01 bc    JE              G78,#3f,#7f [FALSE] ab5a
 a9a0:  41 86 da 73             JE              G76,#da [FALSE] a9d5
 a9a4:  26 da 7f 6f             JIN             "bloody axe",G6f [FALSE] a9d5
 a9a8:  b2 ...                  PRINT           "The troll scratches his head in confusion, then takes the axe."
 a9cd:  bb                      NEW_LINE        
 a9ce:  0b d9 02                SET_ATTR        "troll",#02
 a9d1:  0e da d9                INSERT_OBJ      "bloody axe","troll"
 a9d4:  b0                      RTRUE           
 a9d5:  c1 97 86 d9 da 62       JE              G76,#d9,#da [FALSE] a9fb
 a9db:  b2 ...                  PRINT           "You would have to get the "
 a9e6:  aa 86                   PRINT_OBJ       G76
 a9e8:  b3 ...                  PRINT_RET       " first, and that seems unlikely."
 a9fb:  41 88 7f 6a             JE              G78,#7f [FALSE] aa27
 a9ff:  b2 ...                  PRINT           "The troll, who is remarkably coordinated, catches the "
 aa22:  aa 86                   PRINT_OBJ       G76
 aa24:  8c 00 29                JUMP            aa4e
 aa27:  b2 ...                  PRINT           "The troll, who is not overly proud, graciously accepts the gift"
 aa4e:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 aa52:  23 14 00 00 6e          JG              #14,(SP)+ [FALSE] aac3
 aa57:  c1 95 86 a9 6e da 00 66 JE              G76,#a9,#6e,#da [FALSE] aac3
 aa5f:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 aa65:  b2 ...                  PRINT           " and eats it hungrily. Poor troll, he dies from an internal hemorrhage and his carcass disappears in a sinister black fog."
 aaae:  bb                      NEW_LINE        
 aaaf:  e0 1f 3c 5d d9 00       CALL            78ba (#d9) -> -(SP)
 aab5:  11 d9 11 00             GET_PROP        "troll",#11 -> -(SP)
 aab9:  e0 9f 00 02 00          CALL            (SP)+ (#02) -> -(SP)
 aabe:  0d 9d 01                STORE           G8d,#01
 aac1:  ab 9d                   RET             G8d
 aac3:  c1 95 86 a9 6e da 00 5e JE              G76,#a9,#6e,#da [FALSE] ab27
 aacb:  6e 86 10                INSERT_OBJ      G76,G00
 aace:  b2 ...                  PRINT           " and, being for the moment sated, throws it back. Fortunately, the troll has poor control, and the "
 ab01:  aa 86                   PRINT_OBJ       G76
 ab03:  b2 ...                  PRINT           " falls to the floor. He does not look pleased."
 ab22:  bb                      NEW_LINE        
 ab23:  0b d9 02                SET_ATTR        "troll",#02
 ab26:  b0                      RTRUE           
 ab27:  b2 ...                  PRINT           " and not having the most discriminating tastes, gleefully eats it."
 ab52:  bb                      NEW_LINE        
 ab53:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 ab59:  b8                      RET_POPPED      
 ab5a:  c1 97 88 58 5d 7d       JE              G78,#58,#5d [FALSE] ab9b
 ab60:  b3 ...                  PRINT_RET       "The troll spits in your face, grunting "Better luck next time" in a rather barbarous accent."
 ab9b:  41 88 2a 40             JE              G78,#2a [FALSE] RFALSE
 ab9f:  b3 ...                  PRINT_RET       "The troll laughs at your puny gesture."
 abb4:  41 88 4d 77             JE              G78,#4d [FALSE] abed
 abb8:  b3 ...                  PRINT_RET       "Every so often the troll says something, probably uncomplimentary, in his guttural tongue."
 abed:  a0 9d c0                JZ              G8d [TRUE] RFALSE
 abf0:  41 88 42 40             JE              G78,#42 [FALSE] RFALSE
 abf4:  b3 ...                  PRINT_RET       "Unfortunately, the troll can't hear you."

Routine ac04, 0 locals ()

 ac05:  0a ae 0b c0             TEST_ATTR       "grating",#0b [TRUE] RFALSE
 ac09:  a0 3e 40                JZ              G2e [FALSE] RFALSE
 ac0c:  c1 97 88 5d 58 67       JE              G78,#5d,#58 [FALSE] ac37
 ac12:  b2 ...                  PRINT           "In disturbing the pile of leaves, a grating is revealed."
 ac33:  bb                      NEW_LINE        
 ac34:  8c 00 1e                JUMP            ac53
 ac37:  b2 ...                  PRINT           "With the leaves moved, a grating is revealed."
 ac52:  bb                      NEW_LINE        
 ac53:  0c ae 07                CLEAR_ATTR      "grating",#07
 ac56:  0d 3e 01                STORE           G2e,#01
 ac59:  b1                      RFALSE          

Routine ac5a, 0 locals ()

 ac5b:  41 88 25 57             JE              G78,#25 [FALSE] ac74
 ac5f:  b3 ...                  PRINT_RET       "There are 69,105 leaves here."
 ac74:  41 88 1c 64             JE              G78,#1c [FALSE] ac9a
 ac78:  e0 3f 56 02 00          CALL            ac04 -> -(SP)
 ac7d:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 ac83:  66 86 10 4d             JIN             G76,G00 [FALSE] ac92
 ac87:  b3 ...                  PRINT_RET       "The leaves burn."
 ac92:  e0 0f 83 33 9c 3f 00    CALL            10666 (S211) -> -(SP)
 ac99:  b8                      RET_POPPED      
 ac9a:  41 88 27 6a             JE              G78,#27 [FALSE] acc6
 ac9e:  b2 ...                  PRINT           "You rustle the leaves around, making quite a mess."
 acbf:  bb                      NEW_LINE        
 acc0:  e0 3f 56 02 00          CALL            ac04 -> -(SP)
 acc5:  b0                      RTRUE           
 acc6:  c1 97 88 5d 58 5b       JE              G78,#5d,#58 [FALSE] ace5
 accc:  41 88 58 4a             JE              G78,#58 [FALSE] acd8
 acd0:  b2 ...                  PRINT           "Done."
 acd7:  bb                      NEW_LINE        
 acd8:  a0 3e 40                JZ              G2e [FALSE] RFALSE
 acdb:  e0 3f 56 02 00          CALL            ac04 -> -(SP)
 ace0:  41 88 5d 41             JE              G78,#5d [FALSE] RTRUE
 ace4:  b1                      RFALSE          
 ace5:  41 88 51 40             JE              G78,#51 [FALSE] RFALSE
 ace9:  a0 3e 40                JZ              G2e [FALSE] RFALSE
 acec:  b3 ...                  PRINT_RET       "Underneath the pile of leaves is a grating. As you release the leaves, the grating is once again concealed from view."

Routine ad30, 1 local (0000)

 ad33:  41 01 02 49             JE              L00,#02 [FALSE] ad3e
 ad37:  a0 3e 40                JZ              G2e [FALSE] RFALSE
 ad3a:  0b ae 07                SET_ATTR        "grating",#07
 ad3d:  b0                      RTRUE           
 ad3e:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 ad42:  b2 ...                  PRINT           "You are in a clearing, with a forest surrounding you on all sides. A path leads south."
 ad75:  0a ae 0b 65             TEST_ATTR       "grating",#0b [FALSE] ad9c
 ad79:  bb                      NEW_LINE        
 ad7a:  b2 ...                  PRINT           "There is an open grating, descending into darkness."
 ad99:  8c 00 21                JUMP            adbb
 ad9c:  a0 3e de                JZ              G2e [TRUE] adbb
 ad9f:  bb                      NEW_LINE        
 ada0:  b2 ...                  PRINT           "There is a grating securely fastened into the ground."
 adbb:  bb                      NEW_LINE        
 adbc:  b0                      RTRUE           

Routine adbe, 1 local (0000)

 adc1:  41 01 02 46             JE              L00,#02 [FALSE] adc9
 adc5:  0c ae 07                CLEAR_ATTR      "grating",#07
 adc8:  b0                      RTRUE           
 adc9:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 adcd:  b2 ...                  PRINT           "You are in a small room near the maze. There are twisty passages in the immediate vicinity."
 adf8:  bb                      NEW_LINE        
 adf9:  0a ae 0b 64             TEST_ATTR       "grating",#0b [FALSE] ae1f
 adfd:  b2 ...                  PRINT           "Above you is an open grating with sunlight pouring in."
 ae1c:  8c 00 40                JUMP            ae5d
 ae1f:  a0 3d d6                JZ              G2d [TRUE] ae36
 ae22:  b2 ...                  PRINT           "Above you is a grating."
 ae33:  8c 00 29                JUMP            ae5d
 ae36:  b2 ...                  PRINT           "Above you is a grating locked with a skull-and-crossbones lock."
 ae5d:  bb                      NEW_LINE        
 ae5e:  b0                      RTRUE           

Routine ae60, 0 locals ()

 ae61:  41 88 2b 4f             JE              G78,#2b [FALSE] ae72
 ae65:  41 87 7a 4b             JE              G77,#7a [FALSE] ae72
 ae69:  e0 15 2b be 85 ae 7a 00 CALL            577c (#85,#ae,#7a) -> -(SP)
 ae71:  b0                      RTRUE           
 ae72:  41 88 4e 69             JE              G78,#4e [FALSE] ae9d
 ae76:  41 10 39 52             JE              G00,#39 [FALSE] ae8a
 ae7a:  0d 3d 00                STORE           G2d,#00
 ae7d:  b3 ...                  PRINT_RET       "The grate is locked."
 ae8a:  41 10 8f 40             JE              G00,#8f [FALSE] RFALSE
 ae8e:  b3 ...                  PRINT_RET       "You can't lock it from this side."
 ae9d:  41 88 85 00 4e          JE              G78,#85 [FALSE] aeee
 aea2:  41 86 ae 00 49          JE              G76,#ae [FALSE] aeee
 aea7:  41 10 39 58             JE              G00,#39 [FALSE] aec1
 aeab:  41 87 7a 54             JE              G77,#7a [FALSE] aec1
 aeaf:  0d 3d 01                STORE           G2d,#01
 aeb2:  b3 ...                  PRINT_RET       "The grate is unlocked."
 aec1:  41 10 8f 57             JE              G00,#8f [FALSE] aeda
 aec5:  41 87 7a 53             JE              G77,#7a [FALSE] aeda
 aec9:  b3 ...                  PRINT_RET       "You can't reach the lock from here."
 aeda:  b2 ...                  PRINT           "Can you unlock a grating with a "
 aee9:  aa 87                   PRINT_OBJ       G77
 aeeb:  b3 ...                  PRINT_RET       "?"
 aeee:  41 88 5c 4f             JE              G78,#5c [FALSE] aeff
 aef2:  b3 ...                  PRINT_RET       "You can't pick the lock."
 aeff:  c1 97 88 23 2b 00 64    JE              G78,#23,#2b [FALSE] af68
 af06:  a0 3d 80 55             JZ              G2d [TRUE] af5d
 af0a:  41 10 4a 49             JE              G00,#4a [FALSE] af15
 af0e:  e8 3f 9c 49             PUSH            S212
 af12:  8c 00 06                JUMP            af19
 af15:  e8 3f 9c 4d             PUSH            S213
 af19:  e0 18 4a fd ae 00 91 11 00 
                               CALL            95fa (#ae,(SP)+,S090) -> -(SP)
 af22:  0a ae 0b 75             TEST_ATTR       "grating",#0b [FALSE] af59
 af26:  41 10 4a ed             JE              G00,#4a [TRUE] af55
 af2a:  a0 3e 6a                JZ              G2e [FALSE] af55
 af2d:  b2 ...                  PRINT           "A pile of leaves falls onto your head and to the ground."
 af4e:  bb                      NEW_LINE        
 af4f:  0d 3e 01                STORE           G2e,#01
 af52:  2e 90 10                INSERT_OBJ      "pile of leaves",G00
 af55:  0b 39 14                SET_ATTR        "Grating Room",#14
 af58:  b0                      RTRUE           
 af59:  0c 39 14                CLEAR_ATTR      "Grating Room",#14
 af5c:  b0                      RTRUE           
 af5d:  b3 ...                  PRINT_RET       "The grating is locked."
 af68:  41 88 12 40             JE              G78,#12 [FALSE] RFALSE
 af6c:  41 87 ae 40             JE              G77,#ae [FALSE] RFALSE
 af70:  51 86 0f 00             GET_PROP        G76,#0f -> -(SP)
 af74:  43 00 14 51             JG              (SP)+,#14 [FALSE] af87
 af78:  b3 ...                  PRINT_RET       "It won't fit through the grating."
 af87:  4e 86 39                INSERT_OBJ      G76,"Grating Room"
 af8a:  b2 ...                  PRINT           "The "
 af8d:  aa 86                   PRINT_OBJ       G76
 af8f:  b3 ...                  PRINT_RET       " goes through the grating into the darkness below."

Routine afa6, 0 locals ()

 afa7:  b2 ...                  PRINT           "You won't be able to get back up to the tunnel you are going through when it gets to the next room."
 afda:  bb                      NEW_LINE        
 afdb:  bb                      NEW_LINE        
 afdc:  41 10 45 44             JE              G00,#45 [FALSE] afe2
 afe0:  9b 43                   RET             #43
 afe2:  41 10 3f 44             JE              G00,#3f [FALSE] afe8
 afe6:  9b 42                   RET             #42
 afe8:  41 10 3c 44             JE              G00,#3c [FALSE] afee
 afec:  9b 3a                   RET             #3a
 afee:  41 10 38 40             JE              G00,#38 [FALSE] RFALSE
 aff2:  9b a7                   RET             #a7

Routine aff4, 0 locals ()

 aff5:  41 88 5d 00 3f          JE              G78,#5d [FALSE] b037
 affa:  26 6e 7f 40             JIN             "sword",G6f [FALSE] RFALSE
 affe:  b2 ...                  PRINT           "As you touch the rusty knife, your sword gives a single pulse of blinding blue light."
 b035:  bb                      NEW_LINE        
 b036:  b1                      RFALSE          
 b037:  41 87 80 46             JE              G77,#80 [FALSE] b03f
 b03b:  41 88 13 cd             JE              G78,#13 [TRUE] b04a
 b03f:  41 88 7e 40             JE              G78,#7e [FALSE] RFALSE
 b043:  41 86 80 40             JE              G76,#80 [FALSE] RFALSE
 b047:  a0 87 c0                JZ              G77 [TRUE] RFALSE
 b04a:  e0 1f 3c 5d 80 00       CALL            78ba (#80) -> -(SP)
 b050:  e0 0f 83 33 9c 59 00    CALL            10666 (S214) -> -(SP)
 b057:  b8                      RET_POPPED      

Routine b058, 0 locals ()

 b059:  41 88 5d 40             JE              G78,#5d [FALSE] RFALSE
 b05d:  0c ca 0e                CLEAR_ATTR      "table",#0e
 b060:  b1                      RFALSE          

Routine b062, 0 locals ()

 b063:  c1 95 88 58 6e 5d d0    JE              G78,#58,#6e,#5d [TRUE] b078
 b06a:  c1 95 88 54 69 65 c9    JE              G78,#54,#69,#65 [TRUE] b078
 b071:  c1 95 88 48 46 13 40    JE              G78,#48,#46,#13 [FALSE] RFALSE
 b078:  b2 ...                  PRINT           "A ghost appears in the room and is appalled at your desecration of the remains of a fellow adventurer. He casts a curse on your valuables and banishes them to the Land of the Living Dead. The ghost leaves, muttering obscenities."
 b0fb:  bb                      NEW_LINE        
 b0fc:  e0 25 81 dc 10 e6 64 00 CALL            103b8 (G00,#e6,#64) -> -(SP)
 b104:  e0 17 81 dc 04 e6 00    CALL            103b8 (#04,#e6) -> -(SP)
 b10b:  b0                      RTRUE           

Routine b10c, 0 locals ()

 b10d:  41 88 38 51             JE              G78,#38 [FALSE] b120
 b111:  b3 ...                  PRINT_RET       "The torch is burning."
 b120:  41 88 61 5d             JE              G78,#61 [FALSE] b13f
 b124:  41 87 68 59             JE              G77,#68 [FALSE] b13f
 b128:  b3 ...                  PRINT_RET       "The water evaporates before it gets close."
 b13f:  41 88 16 40             JE              G78,#16 [FALSE] RFALSE
 b143:  4a 86 14 40             TEST_ATTR       G76,#14 [FALSE] RFALSE
 b147:  b3 ...                  PRINT_RET       "You nearly burn your hand trying to extinguish the flame."

Routine b168, 1 local (0000)

 b16b:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 b16f:  b2 ...                  PRINT           "You are in a large square room with tall ceilings. On the south wall is an enormous mirror which fills the entire wall. There are exits on the other three sides of the room."
 b1c4:  bb                      NEW_LINE        
 b1c5:  a0 3c c0                JZ              G2c [TRUE] RFALSE
 b1c8:  b3 ...                  PRINT_RET       "Unfortunately, the mirror has been destroyed by your recklessness."

Routine b1ec, 4 locals (0098, 0000, 0000, 0000)

 b1f5:  a0 3c 00 8f             JZ              G2c [FALSE] b286
 b1f9:  41 88 6e 00 8a          JE              G78,#6e [FALSE] b286
 b1fe:  a0 87 e8                JZ              G77 [TRUE] b227
 b201:  41 87 01 e4             JE              G77,#01 [TRUE] b227
 b205:  b2 ...                  PRINT           "You feel a faint tingling transmitted through the "
 b222:  aa 87                   PRINT_OBJ       G77
 b224:  b3 ...                  PRINT_RET       "."
 b227:  61 10 01 45             JE              G00,L00 [FALSE] b22e
 b22b:  0d 01 96                STORE           L00,#96
 b22e:  a2 10 02 c2             GET_CHILD       G00 -> L01 [TRUE] b232
 b232:  a2 01 03 c2             GET_CHILD       L00 -> L02 [TRUE] b236
 b236:  a0 02 45                JZ              L01 [FALSE] b23c
 b239:  8c 00 0f                JUMP            b249
 b23c:  a1 02 04 c2             GET_SIBLING     L01 -> L03 [TRUE] b240
 b240:  6e 02 01                INSERT_OBJ      L01,L00
 b243:  2d 02 04                STORE           L01,L03
 b246:  8c ff ef                JUMP            b236
 b249:  a0 03 45                JZ              L02 [FALSE] b24f
 b24c:  8c 00 0f                JUMP            b25c
 b24f:  a1 03 04 c2             GET_SIBLING     L02 -> L03 [TRUE] b253
 b253:  6e 03 10                INSERT_OBJ      L02,G00
 b256:  2d 03 04                STORE           L02,L03
 b259:  8c ff ef                JUMP            b249
 b25c:  e0 27 49 5b 01 00 00    CALL            92b6 (L00,#00) -> -(SP)
 b263:  b3 ...                  PRINT_RET       "There is a rumble from deep within the earth and the room shakes."
 b286:  c1 97 88 38 39 7c       JE              G78,#38,#39 [FALSE] b2c6
 b28c:  a0 3c dc                JZ              G2c [TRUE] b2a9
 b28f:  b2 ...                  PRINT           "The mirror is broken into many pieces."
 b2a6:  8c 00 1d                JUMP            b2c4
 b2a9:  b2 ...                  PRINT           "There is an ugly person staring back at you."
 b2c4:  bb                      NEW_LINE        
 b2c5:  b0                      RTRUE           
 b2c6:  41 88 5d 5f             JE              G78,#5d [FALSE] b2e7
 b2ca:  b3 ...                  PRINT_RET       "The mirror is many times your size. Give up."
 b2e7:  c1 95 88 13 7f 2a 40    JE              G78,#13,#7f,#2a [FALSE] RFALSE
 b2ee:  a0 3c df                JZ              G2c [TRUE] b30e
 b2f1:  b3 ...                  PRINT_RET       "Haven't you done enough damage already?"
 b30e:  0d 3c 01                STORE           G2c,#01
 b311:  0d 4c 00                STORE           G3c,#00
 b314:  b3 ...                  PRINT_RET       "You have broken the mirror. I hope you have a seven years' supply of good luck handy."

Routine b348, 1 local (0000)

 b34b:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 b34f:  b2 ...                  PRINT           "This is a large room with a prominent doorway leading to a down staircase. Above you is a large dome. Up around the edge of the dome (20 feet up) is a wooden railing. In the center of the room sits a white marble pedestal."
 b3d0:  bb                      NEW_LINE        
 b3d1:  a0 a3 c0                JZ              G93 [TRUE] RFALSE
 b3d4:  b3 ...                  PRINT_RET       "A piece of rope descends from the railing above, ending some five feet above your head."

Routine b40c, 1 local (0000)

 b40f:  41 01 03 00 94          JE              L00,#03 [FALSE] b4a6
 b414:  b2 ...                  PRINT           "You are at the periphery of a large dome, which forms the ceiling of another room below. Protecting you from a precipitous drop is a wooden railing which circles the dome."
 b471:  bb                      NEW_LINE        
 b472:  a0 a3 c0                JZ              G93 [TRUE] RFALSE
 b475:  b3 ...                  PRINT_RET       "Hanging down from the railing is a rope which ends about ten feet from the floor below."
 b4a6:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
 b4aa:  a0 4e 80 45             JZ              G3e [TRUE] b4f1
 b4ae:  b2 ...                  PRINT           "As you enter the dome you feel a strong pull as if from a wind drawing you over the railing and down."
 b4e9:  bb                      NEW_LINE        
 b4ea:  4e 7f 69                INSERT_OBJ      G6f,"Torch Room"
 b4ed:  0d 10 69                STORE           G00,#69
 b4f0:  b0                      RTRUE           
 b4f1:  41 88 45 40             JE              G78,#45 [FALSE] RFALSE
 b4f5:  e0 0f 83 33 9c 97 00    CALL            10666 (S215) -> -(SP)
 b4fc:  b8                      RET_POPPED      

Routine b4fe, 1 local (0000)

 b501:  41 01 03 00 d9          JE              L00,#03 [FALSE] b5dd
 b506:  b2 ...                  PRINT           "You are outside a large gateway, on which is inscribed

  Abandon every hope all ye who enter here!

The gate is open; through it you can see a desolation, with a pile of mangled bodies in one corner. Thousands of voices, lamenting some hideous fate, can be heard."
 b5a5:  bb                      NEW_LINE        
 b5a6:  a0 a1 40                JZ              G91 [FALSE] RFALSE
 b5a9:  a0 4e 40                JZ              G3e [FALSE] RFALSE
 b5ac:  b3 ...                  PRINT_RET       "The way through the gate is barred by evil spirits, who jeer at your attempts to pass."
 b5dd:  41 01 01 02 06          JE              L00,#01 [FALSE] b7e6
 b5e2:  41 88 3a 7b             JE              G78,#3a [FALSE] b61f
 b5e6:  a0 a1 40                JZ              G91 [FALSE] RFALSE
 b5e9:  26 dd 7f 5d             JIN             "brass bell",G6f [FALSE] b608
 b5ed:  26 d3 7f 59             JIN             "black book",G6f [FALSE] b608
 b5f1:  26 93 7f 55             JIN             "pair of candles",G6f [FALSE] b608
 b5f5:  b3 ...                  PRINT_RET       "You must perform the ceremony."
 b608:  b3 ...                  PRINT_RET       "You aren't equipped for an exorcism."
 b61f:  a0 a1 00 fb             JZ              G91 [FALSE] b71c
 b623:  41 88 6d 00 f6          JE              G78,#6d [FALSE] b71c
 b628:  41 86 dd 00 f1          JE              G76,#dd [FALSE] b71c
 b62d:  0d 3a 01                STORE           G2a,#01
 b630:  e0 1f 3c 5d dd 00       CALL            78ba (#dd) -> -(SP)
 b636:  e0 1f 4a 98 db 00       CALL            9530 (#db) -> -(SP)
 b63c:  2e db 10                INSERT_OBJ      "red hot brass bell",G00
 b63f:  b2 ...                  PRINT           "The bell suddenly becomes red hot and falls to the ground. The wraiths, as if paralyzed, stop their jeering and slowly turn to face you. On their ashen faces, the expression of a long-forgotten terror takes shape."
 b6c6:  bb                      NEW_LINE        
 b6c7:  26 93 7f 78             JIN             "pair of candles",G6f [FALSE] b701
 b6cb:  b2 ...                  PRINT           "In your confusion, the candles drop to the ground (and they are out)."
 b6ee:  bb                      NEW_LINE        
 b6ef:  2e 93 10                INSERT_OBJ      "pair of candles",G00
 b6f2:  0c 93 14                CLEAR_ATTR      "pair of candles",#14
 b6f5:  e0 0f 2a 43 6f 6a 00    CALL            5486 (#6f6a) -> -(SP)
 b6fc:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 b701:  e0 07 2a 39 5c 3e 06 00 CALL            5472 (#5c3e,#06) -> -(SP)
 b709:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 b70e:  e0 07 2a 39 5c 72 14 00 CALL            5472 (#5c72,#14) -> -(SP)
 b716:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 b71b:  b0                      RTRUE           
 b71c:  a0 39 c0                JZ              G29 [TRUE] RFALSE
 b71f:  41 88 53 40             JE              G78,#53 [FALSE] RFALSE
 b723:  41 86 d3 40             JE              G76,#d3 [FALSE] RFALSE
 b727:  a0 a1 40                JZ              G91 [FALSE] RFALSE
 b72a:  b2 ...                  PRINT           "Each word of the prayer reverberates through the hall in a deafening confusion. As the last word fades, a voice, loud and commanding, speaks: "Begone, fiends!" A heart-stopping scream fills the cavern, and the spirits, sensing a greater power, flee through the walls."
 b7cf:  bb                      NEW_LINE        
 b7d0:  e0 1f 3c 5d e9 00       CALL            78ba (#e9) -> -(SP)
 b7d6:  0d a1 01                STORE           G91,#01
 b7d9:  e0 0f 2a 43 5c 6d 00    CALL            5486 (#5c6d) -> -(SP)
 b7e0:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 b7e5:  b0                      RTRUE           
 b7e6:  41 01 06 40             JE              L00,#06 [FALSE] RFALSE
 b7ea:  a0 3a c0                JZ              G2a [TRUE] RFALSE
 b7ed:  26 93 7f 40             JIN             "pair of candles",G6f [FALSE] RFALSE
 b7f1:  0a 93 14 40             TEST_ATTR       "pair of candles",#14 [FALSE] RFALSE
 b7f5:  a0 39 40                JZ              G29 [FALSE] RFALSE
 b7f8:  0d 39 01                STORE           G29,#01
 b7fb:  b2 ...                  PRINT           "The flames flicker wildly and appear to dance. The earth beneath your feet trembles, and your legs nearly buckle beneath you. The spirits cower at your unearthly power."
 b860:  bb                      NEW_LINE        
 b861:  e0 0f 2a 43 5c 3e 00    CALL            5486 (#5c3e) -> -(SP)
 b868:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 b86d:  e0 07 2a 39 5c 6d 03 00 CALL            5472 (#5c6d,#03) -> -(SP)
 b875:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 b87a:  b0                      RTRUE           

Routine b87c, 0 locals ()

 b87d:  a0 39 00 55             JZ              G29 [FALSE] b8d4
 b881:  41 10 e8 00 50          JE              G00,#e8 [FALSE] b8d4
 b886:  b2 ...                  PRINT           "The tension of this ceremony is broken, and the wraiths, amused but shaken at your clumsy attempt, resume their hideous jeering."
 b8d3:  bb                      NEW_LINE        
 b8d4:  0d 3a 00                STORE           G2a,#00
 b8d7:  ab 3a                   RET             G2a

Routine b8da, 0 locals ()

 b8db:  0d 39 00                STORE           G29,#00
 b8de:  e0 3f 5c 3e 00          CALL            b87c -> -(SP)
 b8e3:  b8                      RET_POPPED      

Routine b8e4, 0 locals ()

 b8e5:  e0 1f 3c 5d db 00       CALL            78ba (#db) -> -(SP)
 b8eb:  0e dd e8                INSERT_OBJ      "brass bell","Entrance to Hades"
 b8ee:  41 10 e8 40             JE              G00,#e8 [FALSE] RFALSE
 b8f2:  b3 ...                  PRINT_RET       "The bell appears to have cooled down."

Routine b906, 1 local (0000)

 b909:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 b90d:  b2 ...                  PRINT           "You are standing on the top of the Flood Control Dam #3, which was quite a tourist attraction in times far distant. There are paths to the north, south, and west, and a scramble down."
 b97a:  bb                      NEW_LINE        
 b97b:  a0 a0 80 49             JZ              G90 [TRUE] b9c6
 b97f:  a0 37 80 45             JZ              G27 [TRUE] b9c6
 b983:  b2 ...                  PRINT           "The water level behind the dam is low: The sluice gates have been opened. Water rushes through the dam and downstream."
 b9c2:  bb                      NEW_LINE        
 b9c3:  8c 00 ce                JUMP            ba92
 b9c6:  a0 37 fb                JZ              G27 [TRUE] ba02
 b9c9:  b2 ...                  PRINT           "The sluice gates are open, and water rushes through the dam. The water level behind the dam is still high."
 b9fe:  bb                      NEW_LINE        
 b9ff:  8c 00 92                JUMP            ba92
 ba02:  a0 a0 fb                JZ              G90 [TRUE] ba3e
 ba05:  b2 ...                  PRINT           "The sluice gates are closed. The water level in the reservoir is quite low, but the level is rising quickly."
 ba3a:  bb                      NEW_LINE        
 ba3b:  8c 00 56                JUMP            ba92
 ba3e:  b2 ...                  PRINT           "The sluice gates on the dam are closed. Behind the dam, there can be seen a wide reservoir. Water is pouring over the top of the now abandoned dam."
 ba91:  bb                      NEW_LINE        
 ba92:  b2 ...                  PRINT           "There is a control panel here, on which a large metal bolt is mounted. Directly above the bolt is a small green plastic bubble"
 bad9:  a0 38 d1                JZ              G28 [TRUE] baeb
 badc:  b2 ...                  PRINT           " which is glowing serenely"
 baeb:  b3 ...                  PRINT_RET       "."

Routine baee, 0 locals ()

 baef:  41 88 59 00 c8          JE              G78,#59 [FALSE] bbba
 baf4:  41 87 5b 00 9d          JE              G77,#5b [FALSE] bb94
 baf9:  a0 38 80 82             JZ              G28 [TRUE] bb7d
 bafd:  0c 32 03                CLEAR_ATTR      "Reservoir South",#03
 bb00:  a0 37 80 46             JZ              G27 [TRUE] bb48
 bb04:  0d 37 00                STORE           G27,#00
 bb07:  0c 8a 03                CLEAR_ATTR      "Loud Room",#03
 bb0a:  b2 ...                  PRINT           "The sluice gates close and water starts to collect behind the dam."
 bb31:  bb                      NEW_LINE        
 bb32:  e0 07 2a 39 5e 14 08 00 CALL            5472 (#5e14,#08) -> -(SP)
 bb3a:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 bb3f:  e0 07 2a 39 5e 94 00 00 CALL            5472 (#5e94,#00) -> -(SP)
 bb47:  b0                      RTRUE           
 bb48:  0d 37 01                STORE           G27,#01
 bb4b:  b2 ...                  PRINT           "The sluice gates open and water pours through the dam."
 bb66:  bb                      NEW_LINE        
 bb67:  e0 07 2a 39 5e 94 08 00 CALL            5472 (#5e94,#08) -> -(SP)
 bb6f:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 bb74:  e0 07 2a 39 5e 14 00 00 CALL            5472 (#5e14,#00) -> -(SP)
 bb7c:  b0                      RTRUE           
 bb7d:  b3 ...                  PRINT_RET       "The bolt won't turn with your best effort."
 bb94:  a0 87 d8                JZ              G77 [TRUE] bbad
 bb97:  b2 ...                  PRINT           "The bolt won't turn using the "
 bba8:  aa 87                   PRINT_OBJ       G77
 bbaa:  b3 ...                  PRINT_RET       "."
 bbad:  b3 ...                  PRINT_RET       "You can't with your bare hands."
 bbba:  41 88 5d 48             JE              G78,#5d [FALSE] bbc4
 bbbe:  e0 3f 5e 06 00          CALL            bc0c -> -(SP)
 bbc3:  b8                      RET_POPPED      
 bbc4:  41 88 55 40             JE              G78,#55 [FALSE] RFALSE
 bbc8:  b3 ...                  PRINT_RET       "Hmm. It appears the tube contained glue, not oil. Turning the bolt won't get any easier...."

Routine bc00, 0 locals ()

 bc01:  41 88 5d 40             JE              G78,#5d [FALSE] RFALSE
 bc05:  e0 3f 5e 06 00          CALL            bc0c -> -(SP)
 bc0a:  b8                      RET_POPPED      

Routine bc0c, 0 locals ()

 bc0d:  b3 ...                  PRINT_RET       "It is an integral part of the control panel."

Routine bc28, 0 locals ()

 bc29:  0b 64 04                SET_ATTR        "Reservoir",#04
 bc2c:  0c 64 06                CLEAR_ATTR      "Reservoir",#06
 bc2f:  0c 28 03                CLEAR_ATTR      "Deep Canyon",#03
 bc32:  0c 8a 03                CLEAR_ATTR      "Loud Room",#03
 bc35:  06 65 64 45             JIN             "trunk of jewels","Reservoir" [FALSE] bc3c
 bc39:  0b 65 07                SET_ATTR        "trunk of jewels",#07
 bc3c:  0d a0 00                STORE           G90,#00
 bc3f:  41 10 64 7c             JE              G00,#64 [FALSE] bc7d
 bc43:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 bc46:  4a 00 1b 6d             TEST_ATTR       (SP)+,#1b [FALSE] bc75
 bc4a:  b3 ...                  PRINT_RET       "The boat lifts gently out of the mud and is now floating on the reservoir."
 bc75:  e0 0f 83 33 9c a7 00    CALL            10666 (S216) -> -(SP)
 bc7c:  b0                      RTRUE           
 bc7d:  41 10 28 69             JE              G00,#28 [FALSE] bca8
 bc81:  b3 ...                  PRINT_RET       "A sound, like that of flowing water, starts to come from below."
 bca8:  41 10 8a 00 51          JE              G00,#8a [FALSE] bcfc
 bcad:  b2 ...                  PRINT           "All of a sudden, an alarmingly loud roaring sound fills the room. Filled with fear, you scramble away."
 bcee:  bb                      NEW_LINE        
 bcef:  e0 2f 27 36 36 00       CALL            4e6c (G26) -> -(SP)
 bcf5:  e0 2f 49 5b 00 00       CALL            92b6 ((SP)+) -> -(SP)
 bcfb:  b0                      RTRUE           
 bcfc:  c1 97 10 ac 32 41       JE              G00,#ac,#32 [FALSE] RTRUE
 bd02:  b3 ...                  PRINT_RET       "You notice that the water level has risen to the point that it is impossible to cross."

Routine bd28, 0 locals ()

 bd29:  0b 64 06                SET_ATTR        "Reservoir",#06
 bd2c:  0c 64 04                CLEAR_ATTR      "Reservoir",#04
 bd2f:  0c 28 03                CLEAR_ATTR      "Deep Canyon",#03
 bd32:  0c 8a 03                CLEAR_ATTR      "Loud Room",#03
 bd35:  0c 65 07                CLEAR_ATTR      "trunk of jewels",#07
 bd38:  0d a0 01                STORE           G90,#01
 bd3b:  41 10 64 00 40          JE              G00,#64 [FALSE] bd7e
 bd40:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 bd43:  4a 00 1b 79             TEST_ATTR       (SP)+,#1b [FALSE] bd7e
 bd47:  b3 ...                  PRINT_RET       "The water level has dropped to the point at which the boat can no longer stay afloat. It sinks into the mud."
 bd7e:  41 10 28 5b             JE              G00,#28 [FALSE] bd9b
 bd82:  b3 ...                  PRINT_RET       "The roar of rushing water is quieter now."
 bd9b:  c1 97 10 ac 32 41       JE              G00,#ac,#32 [FALSE] RTRUE
 bda1:  b3 ...                  PRINT_RET       "The water level is now quite low here and you could easily cross over to the other side."

Routine bdcc, 0 locals ()

 bdcd:  41 88 53 53             JE              G78,#53 [FALSE] bde2
 bdd1:  b3 ...                  PRINT_RET       "They're greek to you."
 bde2:  41 88 65 40             JE              G78,#65 [FALSE] RFALSE
 bde6:  41 86 c3 00 76          JE              G76,#c3 [FALSE] be5f
 bdeb:  a0 34 00 5f             JZ              G24 [FALSE] be4c
 bdef:  0c 9f 07                CLEAR_ATTR      "leak",#07
 bdf2:  b2 ...                  PRINT           "There is a rumbling sound and a stream of water appears to burst from the east wall of the room (apparently, a leak has occurred in a pipe)."
 be39:  bb                      NEW_LINE        
 be3a:  0d 34 01                STORE           G24,#01
 be3d:  e0 03 2a 39 5f 89 ff ff 00 
                               CALL            5472 (#5f89,#ffff) -> -(SP)
 be46:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 be4b:  b0                      RTRUE           
 be4c:  b3 ...                  PRINT_RET       "The blue button appears to be jammed."
 be5f:  41 86 c4 6b             JE              G76,#c4 [FALSE] be8c
 be63:  b2 ...                  PRINT           "The lights within the room "
 be72:  4a 10 14 4e             TEST_ATTR       G00,#14 [FALSE] be82
 be76:  4c 10 14                CLEAR_ATTR      G00,#14
 be79:  b3 ...                  PRINT_RET       "shut off."
 be82:  4b 10 14                SET_ATTR        G00,#14
 be85:  b3 ...                  PRINT_RET       "come on."
 be8c:  41 86 c5 4f             JE              G76,#c5 [FALSE] be9d
 be90:  0c d7 03                CLEAR_ATTR      "Dam",#03
 be93:  0d 38 00                STORE           G28,#00
 be96:  b3 ...                  PRINT_RET       "Click."
 be9d:  41 86 c6 40             JE              G76,#c6 [FALSE] RFALSE
 bea1:  0c d7 03                CLEAR_ATTR      "Dam",#03
 bea4:  0d 38 01                STORE           G28,#01
 bea7:  b3 ...                  PRINT_RET       "Click."

Routine beae, 0 locals ()

 beaf:  41 88 38 53             JE              G78,#38 [FALSE] bec4
 beb3:  b3 ...                  PRINT_RET       "The chests are all empty."
 bec4:  c1 95 88 12 2b 5d 75    JE              G78,#12,#2b,#5d [FALSE] befe
 becb:  e0 1f 3c 5d c8 00       CALL            78ba (#c8) -> -(SP)
 bed1:  b3 ...                  PRINT_RET       "The chests are so rusty and corroded that they crumble when you touch them."
 befe:  41 88 2b 40             JE              G78,#2b [FALSE] RFALSE
 bf02:  b3 ...                  PRINT_RET       "The chests are already open."

Routine bf12, 1 local (0000)

 bf15:  41 10 c7 c8             JE              G00,#c7 [TRUE] bf1f
 bf19:  e8 7f 00                PUSH            #00
 bf1c:  8c 00 05                JUMP            bf22
 bf1f:  e8 7f 01                PUSH            #01
 bf22:  2d 01 00                STORE           L00,(SP)+
 bf25:  a0 01 d8                JZ              L00 [TRUE] bf3e
 bf28:  b2 ...                  PRINT           "The water level here is now "
 bf33:  57 34 02 00             DIV             G24,#02 -> -(SP)
 bf37:  6f 35 00 00             LOADW           G25,(SP)+ -> -(SP)
 bf3b:  ad 00                   PRINT_PADDR     (SP)+
 bf3d:  bb                      NEW_LINE        
 bf3e:  95 34                   INC             G24
 bf40:  42 34 0e dd             JL              G24,#0e [TRUE] bf5f
 bf44:  e0 13 4a 91 c7 9d 34 00 CALL            9522 (#c7,S226) -> -(SP)
 bf4c:  e0 07 2a 39 5f 89 00 00 CALL            5472 (#5f89,#00) -> -(SP)
 bf54:  a0 01 c1                JZ              L00 [TRUE] RTRUE
 bf57:  e0 0f 83 33 9d 3f 00    CALL            10666 (S227) -> -(SP)
 bf5e:  b0                      RTRUE           
 bf5f:  46 7f 9c 41             JIN             G6f,"magic boat" [FALSE] RTRUE
 bf63:  c1 95 10 c7 d7 9a 41    JE              G00,#c7,#d7,#9a [FALSE] RTRUE
 bf6a:  e0 0f 83 33 9d 4d 00    CALL            10666 (S228) -> -(SP)
 bf71:  b0                      RTRUE           

Routine bf72, 0 locals ()

 bf73:  43 34 00 40             JG              G24,#00 [FALSE] RFALSE
 bf77:  c1 97 88 32 12 4c       JE              G78,#32,#12 [FALSE] bf87
 bf7d:  41 86 62 48             JE              G76,#62 [FALSE] bf87
 bf81:  e0 3f 5f ce 00          CALL            bf9c -> -(SP)
 bf86:  b8                      RET_POPPED      
 bf87:  41 88 5f 40             JE              G78,#5f [FALSE] RFALSE
 bf8b:  41 87 62 48             JE              G77,#62 [FALSE] bf95
 bf8f:  e0 3f 5f ce 00          CALL            bf9c -> -(SP)
 bf94:  b8                      RET_POPPED      
 bf95:  e0 2f 60 7f 87 00       CALL            c0fe (G77) -> -(SP)
 bf9b:  b8                      RET_POPPED      

Routine bf9c, 0 locals ()

 bf9d:  cd 4f 34 ff ff          STORE           G24,#ffff
 bfa2:  e0 07 2a 39 5f 89 00 00 CALL            5472 (#5f89,#00) -> -(SP)
 bfaa:  b3 ...                  PRINT_RET       "By some miracle of Zorkian technology, you have managed to stop the leak in the dam."

Routine bfde, 0 locals ()

 bfdf:  41 88 55 46             JE              G78,#55 [FALSE] bfe7
 bfe3:  41 87 62 ca             JE              G77,#62 [TRUE] bfef
 bfe7:  41 88 12 40             JE              G78,#12 [FALSE] RFALSE
 bfeb:  41 86 62 40             JE              G76,#62 [FALSE] RFALSE
 bfef:  b3 ...                  PRINT_RET       "The all-purpose gunk isn't a lubricant."

Routine c00c, 0 locals ()

 c00d:  41 88 12 5d             JE              G78,#12 [FALSE] c02c
 c011:  41 87 63 59             JE              G77,#63 [FALSE] c02c
 c015:  b3 ...                  PRINT_RET       "The tube refuses to accept anything."
 c02c:  41 88 79 40             JE              G78,#79 [FALSE] RFALSE
 c030:  4a 86 0b 62             TEST_ATTR       G76,#0b [FALSE] c054
 c034:  26 62 86 5e             JIN             "viscous material",G76 [FALSE] c054
 c038:  2e 62 7f                INSERT_OBJ      "viscous material",G6f
 c03b:  b3 ...                  PRINT_RET       "The viscous material oozes into your hand."
 c054:  4a 86 0b 55             TEST_ATTR       G76,#0b [FALSE] c06b
 c058:  b3 ...                  PRINT_RET       "The tube is apparently empty."
 c06b:  b3 ...                  PRINT_RET       "The tube is closed."

Routine c074, 0 locals ()

 c075:  c1 97 88 23 2b 5b       JE              G78,#23,#2b [FALSE] c094
 c07b:  b3 ...                  PRINT_RET       "Sounds reasonable, but this isn't how."
 c094:  41 88 5f 40             JE              G78,#5f [FALSE] RFALSE
 c098:  41 87 01 6b             JE              G77,#01 [FALSE] c0c5
 c09c:  b3 ...                  PRINT_RET       "Are you the little Dutch boy, then? Sorry, this is a big dam."
 c0c5:  b2 ...                  PRINT           "With a "
 c0cc:  aa 87                   PRINT_OBJ       G77
 c0ce:  b3 ...                  PRINT_RET       "? Do you know how big this dam is? You could only stop a tiny leak with that."

Routine c0fe, 1 local (0000)

 c101:  b2 ...                  PRINT           "With a "
 c108:  aa 01                   PRINT_OBJ       L00
 c10a:  b3 ...                  PRINT_RET       "?"

Routine c10e, 1 local (0000)

 c111:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 c115:  a0 a0 80 60             JZ              G90 [TRUE] c177
 c119:  a0 37 80 5c             JZ              G27 [TRUE] c177
 c11d:  b2 ...                  PRINT           "You are in a long room, to the north of which was formerly a lake. However, with the water level lowered, there is merely a wide stream running through the center of the room."
 c174:  8c 01 2f                JUMP            c2a4
 c177:  a0 37 80 78             JZ              G27 [TRUE] c1f1
 c17b:  b2 ...                  PRINT           "You are in a long room. To the north is a large lake, too deep to cross. You notice, however, that the water level appears to be dropping at a rapid rate. Before long, it might be possible to cross to the other side from here."
 c1ee:  8c 00 b5                JUMP            c2a4
 c1f1:  a0 a0 80 80             JZ              G90 [TRUE] c273
 c1f5:  b2 ...                  PRINT           "You are in a long room, to the north of which is a wide area which was formerly a reservoir, but now is merely a stream. You notice, however, that the level of the stream is rising quickly and that before long it will be impossible to cross here."
 c270:  8c 00 33                JUMP            c2a4
 c273:  b2 ...                  PRINT           "You are in a long room on the south shore of a large lake, far too deep and wide for crossing."
 c2a4:  bb                      NEW_LINE        
 c2a5:  b3 ...                  PRINT_RET       "There is a path along the stream to the east or west, a steep pathway climbing southwest along the edge of a chasm, and a path leading into a canyon to the southeast."

Routine c2fc, 1 local (0000)

 c2ff:  41 01 06 00 5b          JE              L00,#06 [FALSE] c35d
 c304:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 c307:  4a 00 1b 80 53          TEST_ATTR       (SP)+,#1b [TRUE] c35d
 c30c:  a0 37 00 4f             JZ              G27 [FALSE] c35d
 c310:  a0 a0 80 4b             JZ              G90 [TRUE] c35d
 c314:  b3 ...                  PRINT_RET       "You notice that the water level here is rising rapidly. The currents are also becoming stronger. Staying here seems quite perilous!"
 c35d:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 c361:  a0 a0 fe                JZ              G90 [TRUE] c3a0
 c364:  b2 ...                  PRINT           "You are on what used to be a large lake, but which is now a large mud pile. There are "shores" to the north and south."
 c39d:  8c 00 59                JUMP            c3f7
 c3a0:  b2 ...                  PRINT           "You are on the lake. Beaches can be seen north and south. Upstream a small stream enters the lake through a narrow cleft in the rocks. The dam can be seen downstream."
 c3f7:  bb                      NEW_LINE        
 c3f8:  b0                      RTRUE           

Routine c3fa, 1 local (0000)

 c3fd:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 c401:  a0 a0 80 5a             JZ              G90 [TRUE] c45d
 c405:  a0 37 80 56             JZ              G27 [TRUE] c45d
 c409:  b2 ...                  PRINT           "You are in a large cavernous room, the south of which was formerly a lake. However, with the water level lowered, there is merely a wide stream running through there."
 c45a:  8c 00 c0                JUMP            c51b
 c45d:  a0 37 fe                JZ              G27 [TRUE] c49c
 c460:  b2 ...                  PRINT           "You are in a large cavernous area. To the south is a wide lake, whose water level appears to be falling rapidly."
 c499:  8c 00 81                JUMP            c51b
 c49c:  a0 a0 80 62             JZ              G90 [TRUE] c500
 c4a0:  b2 ...                  PRINT           "You are in a cavernous area, to the south of which is a very wide stream. The level of the stream is rising rapidly, and it appears that before long it will be impossible to cross to the other side."
 c4fd:  8c 00 1d                JUMP            c51b
 c500:  b2 ...                  PRINT           "You are in a large cavernous room, north of a large lake."
 c51b:  bb                      NEW_LINE        
 c51c:  b3 ...                  PRINT_RET       "There is a slimy stairway leaving the room to the north."

Routine c53c, 1 local (0000)

 c53f:  41 88 7f 6c             JE              G78,#7f [FALSE] c56d
 c543:  41 86 ec 68             JE              G76,#ec [FALSE] c56d
 c547:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 c54d:  0d 01 01                STORE           L00,#01
 c550:  b2 ...                  PRINT           "The bottle hits the far wall and shatters."
 c569:  bb                      NEW_LINE        
 c56a:  8c 00 3f                JUMP            c5aa
 c56d:  41 88 2a 6c             JE              G78,#2a [FALSE] c59b
 c571:  0d 01 01                STORE           L00,#01
 c574:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 c57a:  b2 ...                  PRINT           "A brilliant maneuver destroys the bottle."
 c597:  bb                      NEW_LINE        
 c598:  8c 00 11                JUMP            c5aa
 c59b:  41 88 73 4d             JE              G78,#73 [FALSE] c5aa
 c59f:  4a 86 0b 49             TEST_ATTR       G76,#0b [FALSE] c5aa
 c5a3:  26 ed 86 45             JIN             "quantity of water",G76 [FALSE] c5aa
 c5a7:  0d 01 01                STORE           L00,#01
 c5aa:  a0 01 e7                JZ              L00 [TRUE] c5d2
 c5ad:  26 ed 86 63             JIN             "quantity of water",G76 [FALSE] c5d2
 c5b1:  b2 ...                  PRINT           "The water spills to the floor and evaporates."
 c5ca:  bb                      NEW_LINE        
 c5cb:  e0 1f 3c 5d ed 00       CALL            78ba (#ed) -> -(SP)
 c5d1:  b0                      RTRUE           
 c5d2:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 c5d5:  b0                      RTRUE           

Routine c5d6, 1 local (0000)

 c5d9:  2d 01 33                STORE           L00,G23
 c5dc:  41 7f ba 00 4f          JE              G6f,#ba [FALSE] c62e
 c5e1:  a0 a5 e1                JZ              G95 [TRUE] c603
 c5e4:  b3 ...                  PRINT_RET       "No use talking to him. He's fast asleep."
 c603:  41 88 5b 4c             JE              G78,#5b [FALSE] c611
 c607:  0d 7f 04                STORE           G6f,#04
 c60a:  e0 1f 2b be 5b 00       CALL            577c (#5b) -> -(SP)
 c610:  b0                      RTRUE           
 c611:  b3 ...                  PRINT_RET       "The cyclops prefers eating to making conversation."
 c62e:  a0 a5 80 6d             JZ              G95 [TRUE] c69d
 c632:  41 88 38 65             JE              G78,#38 [FALSE] c659
 c636:  b3 ...                  PRINT_RET       "The cyclops is sleeping like a baby, albeit a very ugly one."
 c659:  c1 95 88 13 46 88 c8    JE              G78,#13,#46,#88 [TRUE] c666
 c660:  c1 97 88 2a 1c 40       JE              G78,#2a,#1c [FALSE] RFALSE
 c666:  b2 ...                  PRINT           "The cyclops yawns and stares at the thing that woke him up."
 c687:  bb                      NEW_LINE        
 c688:  0d a5 00                STORE           G95,#00
 c68b:  0b ba 02                SET_ATTR        "cyclops",#02
 c68e:  42 01 00 48             JL              L00,#00 [FALSE] c698
 c692:  35 00 01 33             SUB             #00,L00 -> G23
 c696:  ab 33                   RET             G23
 c698:  2d 33 01                STORE           G23,L00
 c69b:  ab 33                   RET             G23
 c69d:  41 88 38 61             JE              G78,#38 [FALSE] c6c0
 c6a1:  b3 ...                  PRINT_RET       "A hungry cyclops is standing at the foot of the stairs."
 c6c0:  41 88 3f 01 ae          JE              G78,#3f [FALSE] c871
 c6c5:  41 87 ba 01 a9          JE              G77,#ba [FALSE] c871
 c6ca:  41 86 e1 00 a4          JE              G76,#e1 [FALSE] c771
 c6cf:  42 01 00 80 90          JL              L00,#00 [TRUE] c762
 c6d4:  e0 1f 3c 5d e1 00       CALL            78ba (#e1) -> -(SP)
 c6da:  b2 ...                  PRINT           "The cyclops says "Mmm Mmm. I love hot peppers! But oh, could I use a drink. Perhaps I could drink the blood of that thing."  From the gleam in his eye, it could be surmised that you are "that thing"."
 c755:  bb                      NEW_LINE        
 c756:  35 00 01 00             SUB             #00,L00 -> -(SP)
 c75a:  e0 0b 6f a4 ff ff 00 33 CALL            df48 (#ffff,(SP)+) -> G23
 c762:  e0 03 2a 39 64 9f ff ff 00 
                               CALL            5472 (#649f,#ffff) -> -(SP)
 c76b:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 c770:  b0                      RTRUE           
 c771:  41 86 ed cc             JE              G76,#ed [TRUE] c77f
 c775:  41 86 ec 00 c3          JE              G76,#ec [FALSE] c83b
 c77a:  06 ed ec 00 be          JIN             "quantity of water","glass bottle" [FALSE] c83b
 c77f:  42 01 00 00 92          JL              L00,#00 [FALSE] c814
 c784:  e0 1f 3c 5d ed 00       CALL            78ba (#ed) -> -(SP)
 c78a:  2e ec 10                INSERT_OBJ      "glass bottle",G00
 c78d:  0b ec 0b                SET_ATTR        "glass bottle",#0b
 c790:  0c ba 02                CLEAR_ATTR      "cyclops",#02
 c793:  b2 ...                  PRINT           "The cyclops takes the bottle, checks that it's open, and drinks the water. A moment later, he lets out a yawn that nearly blows you over, and then falls fast asleep (what did you put in that drink, anyway?)."
 c80e:  bb                      NEW_LINE        
 c80f:  0d a5 01                STORE           G95,#01
 c812:  ab a5                   RET             G95
 c814:  b3 ...                  PRINT_RET       "The cyclops apparently is not thirsty and refuses your generous offer."
 c83b:  41 86 bd 59             JE              G76,#bd [FALSE] c856
 c83f:  b3 ...                  PRINT_RET       "The cyclops may be hungry, but there is a limit."
 c856:  b3 ...                  PRINT_RET       "The cyclops is not so stupid as to eat THAT!"
 c871:  c1 95 88 2a 13 7f 00 6d JE              G78,#2a,#13,#7f [FALSE] c8e4
 c879:  e0 03 2a 39 64 9f ff ff 00 
                               CALL            5472 (#649f,#ffff) -> -(SP)
 c882:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 c887:  41 88 2a 6f             JE              G78,#2a [FALSE] c8b8
 c88b:  b3 ...                  PRINT_RET       ""Do you think I'm as stupid as my father was?", he says, dodging."
 c8b8:  b2 ...                  PRINT           "The cyclops shrugs but otherwise ignores your pitiful attempt."
 c8db:  bb                      NEW_LINE        
 c8dc:  41 88 7f 41             JE              G78,#7f [FALSE] RTRUE
 c8e0:  6e 86 10                INSERT_OBJ      G76,G00
 c8e3:  b0                      RTRUE           
 c8e4:  41 88 5d 5b             JE              G78,#5d [FALSE] c901
 c8e8:  b3 ...                  PRINT_RET       "The cyclops doesn't take kindly to being grabbed."
 c901:  41 88 82 61             JE              G78,#82 [FALSE] c924
 c905:  b3 ...                  PRINT_RET       "You cannot tie the cyclops, though he is fit to be tied."
 c924:  41 88 4d 40             JE              G78,#4d [FALSE] RFALSE
 c928:  b3 ...                  PRINT_RET       "You can hear his stomach rumbling."

Routine c93e, 0 locals ()

 c93f:  a0 a5 41                JZ              G95 [FALSE] RTRUE
 c942:  a0 4e 41                JZ              G3e [FALSE] RTRUE
 c945:  41 10 b9 cf             JE              G00,#b9 [TRUE] c956
 c949:  e0 0f 2a 43 64 9f 00    CALL            5486 (#649f) -> -(SP)
 c950:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 c955:  b0                      RTRUE           
 c956:  42 33 00 49             JL              G23,#00 [FALSE] c961
 c95a:  35 00 33 00             SUB             #00,G23 -> -(SP)
 c95e:  8c 00 05                JUMP            c964
 c961:  e8 bf 33                PUSH            G23
 c964:  43 00 05 56             JG              (SP)+,#05 [FALSE] c97c
 c968:  e0 0f 2a 43 64 9f 00    CALL            5486 (#649f) -> -(SP)
 c96f:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 c974:  e0 0f 83 33 9d 66 00    CALL            10666 (S229) -> -(SP)
 c97b:  b8                      RET_POPPED      
 c97c:  42 33 00 47             JL              G23,#00 [FALSE] c985
 c980:  96 33                   DEC             G23
 c982:  8c 00 04                JUMP            c987
 c985:  95 33                   INC             G23
 c987:  a0 a5 40                JZ              G95 [FALSE] RFALSE
 c98a:  42 33 00 49             JL              G23,#00 [FALSE] c995
 c98e:  35 00 33 00             SUB             #00,G23 -> -(SP)
 c992:  8c 00 05                JUMP            c998
 c995:  e8 bf 33                PUSH            G23
 c998:  55 00 01 00             SUB             (SP)+,#01 -> -(SP)
 c99c:  6f 32 00 00             LOADW           G22,(SP)+ -> -(SP)
 c9a0:  ad 00                   PRINT_PADDR     (SP)+
 c9a2:  bb                      NEW_LINE        
 c9a3:  b0                      RTRUE           

Routine c9a4, 1 local (0000)

 c9a7:  41 01 03 01 a7          JE              L00,#03 [FALSE] cb51
 c9ac:  b2 ...                  PRINT           "This room has an exit on the northwest, and a staircase leading up."
 c9c9:  bb                      NEW_LINE        
 c9ca:  a0 a5 e6                JZ              G95 [TRUE] c9f1
 c9cd:  a0 9f 63                JZ              G8f [FALSE] c9f1
 c9d0:  b3 ...                  PRINT_RET       "The cyclops is sleeping blissfully at the foot of the stairs."
 c9f1:  a0 9f ef                JZ              G8f [TRUE] ca21
 c9f4:  b3 ...                  PRINT_RET       "The east wall, previously solid, now has a cyclops-sized opening in it."
 ca21:  a0 33 00 8b             JZ              G23 [FALSE] caae
 ca25:  b3 ...                  PRINT_RET       "A cyclops, who looks prepared to eat horses (much less mere adventurers), blocks the staircase. From his state of health, and the bloodstains on the walls, you gather that he is not very friendly, though he likes people."
 caae:  43 33 00 00 53          JG              G23,#00 [FALSE] cb04
 cab3:  b3 ...                  PRINT_RET       "The cyclops is standing in the corner, eyeing you closely. I don't think he likes you very much. He looks extremely hungry, even for a cyclops."
 cb04:  42 33 00 40             JL              G23,#00 [FALSE] RFALSE
 cb08:  b3 ...                  PRINT_RET       "The cyclops, having eaten the hot peppers, appears to be gasping. His enflamed tongue protrudes from his man-sized mouth."
 cb51:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
 cb55:  a0 33 c1                JZ              G23 [TRUE] RTRUE
 cb58:  e0 0f 2a 43 64 9f 00    CALL            5486 (#649f) -> -(SP)
 cb5f:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 cb64:  b0                      RTRUE           

Routine cb66, 2 locals (0000, 0000)

 cb6b:  41 01 03 00 c3          JE              L00,#03 [FALSE] cc31
 cb70:  b2 ...                  PRINT           "This is a large room with a ceiling which cannot be detected from the ground. There is a narrow passage from east to west and a stone stairway leading upward."
 cbb3:  a0 31 48                JZ              G21 [FALSE] cbbc
 cbb6:  a0 37 5f                JZ              G27 [FALSE] cbd6
 cbb9:  a0 a0 dc                JZ              G90 [TRUE] cbd6
 cbbc:  b2 ...                  PRINT           " The room is eerie in its quietness."
 cbd3:  8c 00 5b                JUMP            cc2f
 cbd6:  b2 ...                  PRINT           " The room is deafeningly loud with an undetermined rushing sound. The sound seems to reverberate from all of the walls, making it difficult even to think."
 cc2f:  bb                      NEW_LINE        
 cc30:  b0                      RTRUE           
 cc31:  41 01 06 00 88          JE              L00,#06 [FALSE] ccbc
 cc36:  a0 37 80 84             JZ              G27 [TRUE] ccbc
 cc3a:  a0 a0 00 80             JZ              G90 [FALSE] ccbc
 cc3e:  b2 ...                  PRINT           "It is unbearably loud here, with an ear-splitting roar seeming to come from all around you. There is a pounding in your head which won't stop. With a tremendous effort, you scramble out of the room."
 ccad:  bb                      NEW_LINE        
 ccae:  bb                      NEW_LINE        
 ccaf:  e0 2f 27 36 36 00       CALL            4e6c (G26) -> -(SP)
 ccb5:  e0 2f 49 5b 00 00       CALL            92b6 ((SP)+) -> -(SP)
 ccbb:  b1                      RFALSE          
 ccbc:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
 ccc0:  a0 31 40                JZ              G21 [FALSE] RFALSE
 ccc3:  a0 37 45                JZ              G27 [FALSE] ccc9
 ccc6:  a0 a0 40                JZ              G90 [FALSE] RFALSE
 ccc9:  a0 37 c5                JZ              G27 [TRUE] cccf
 cccc:  a0 a0 c0                JZ              G90 [TRUE] RFALSE
 cccf:  e0 3f 46 44 00          CALL            8c88 -> -(SP)
 ccd4:  a0 7c e5                JZ              G6c [TRUE] ccfa
 ccd7:  b2 ...                  PRINT           "The rest of your commands have been lost in the noise."
 ccf6:  bb                      NEW_LINE        
 ccf7:  0d 7c 00                STORE           G6c,#00
 ccfa:  bb                      NEW_LINE        
 ccfb:  b2 ...                  PRINT           ">"
 cd00:  e4 af 7d 7e             READ            G6d,G6e
 cd04:  50 7e 01 00             LOADB           G6e,#01 -> -(SP)
 cd08:  a0 00 53                JZ              (SP)+ [FALSE] cd1c
 cd0b:  b2 ...                  PRINT           "I beg your pardon?"
 cd18:  bb                      NEW_LINE        
 cd19:  8c ff e0                JUMP            ccfa
 cd1c:  4f 7e 01 02             LOADW           G6e,#01 -> L01
 cd20:  c1 80 02 42 36 4d 5e 48 e2 49 
                               JE              L01,"go","walk","run" [FALSE] cd31
 cd2a:  4f 7e 03 02             LOADW           G6e,#03 -> L01
 cd2e:  8c 00 0c                JUMP            cd3b
 cd31:  c1 8f 02 49 21 46       JE              L01,"say" [FALSE] cd3b
 cd37:  4f 7e 05 02             LOADW           G6e,#05 -> L01
 cd3b:  c1 8f 02 49 1a 4a       JE              L01,"save" [FALSE] cd49
 cd41:  e0 3f 37 34 00          CALL            6e68 -> -(SP)
 cd46:  8c ff b3                JUMP            ccfa
 cd49:  c1 8f 02 48 9c 4a       JE              L01,"restor" [FALSE] cd57
 cd4f:  e0 3f 37 29 00          CALL            6e52 -> -(SP)
 cd54:  8c ff a5                JUMP            ccfa
 cd57:  c1 83 02 48 02 48 10 4a JE              L01,"q","quit" [FALSE] cd67
 cd5f:  e0 3f 36 e6 00          CALL            6dcc -> -(SP)
 cd64:  8c ff 95                JUMP            ccfa
 cd67:  c1 83 02 4d 42 4d 88 4a JE              L01,"w","west" [FALSE] cd77
 cd6f:  e0 1f 49 5b 6b 00       CALL            92b6 (#6b) -> -(SP)
 cd75:  ab 00                   RET             (SP)+
 cd77:  c1 83 02 3f ea 3f f1 4a JE              L01,"e","east" [FALSE] cd87
 cd7f:  e0 1f 49 5b 27 00       CALL            92b6 (#27) -> -(SP)
 cd85:  ab 00                   RET             (SP)+
 cd87:  c1 83 02 4c af 4c fc 4a JE              L01,"u","up" [FALSE] cd97
 cd8f:  e0 1f 49 5b 28 00       CALL            92b6 (#28) -> -(SP)
 cd95:  ab 00                   RET             (SP)+
 cd97:  c1 8f 02 3d 74 59       JE              L01,"bug" [FALSE] cdb4
 cd9d:  b2 ...                  PRINT           "That's only your opinion."
 cdb0:  bb                      NEW_LINE        
 cdb1:  8c ff 48                JUMP            ccfa
 cdb4:  c1 8f 02 3f ff 64       JE              L01,"echo" [FALSE] cddc
 cdba:  0d 31 01                STORE           G21,#01
 cdbd:  0c 8b 09                CLEAR_ATTR      "platinum bar",#09
 cdc0:  b2 ...                  PRINT           "The acoustics of the room change subtly."
 cdd9:  bb                      NEW_LINE        
 cdda:  bb                      NEW_LINE        
 cddb:  b0                      RTRUE           
 cddc:  e0 3f 3c 24 00          CALL            7848 -> -(SP)
 cde1:  8c ff 18                JUMP            ccfa

Routine cde4, 1 local (0000)

 cde7:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 cdeb:  b2 ...                  PRINT           "You are on the south edge of a deep canyon. Passages lead off to the east, northwest and southwest. A stairway leads down."
 ce32:  a0 37 f5                JZ              G27 [TRUE] ce68
 ce35:  a0 a0 72                JZ              G90 [FALSE] ce68
 ce38:  b2 ...                  PRINT           " You can hear a loud roaring sound, like that of rushing water, from below."
 ce65:  8c 00 25                JUMP            ce8b
 ce68:  a0 37 47                JZ              G27 [FALSE] ce70
 ce6b:  a0 a0 c4                JZ              G90 [TRUE] ce70
 ce6e:  bb                      NEW_LINE        
 ce6f:  b0                      RTRUE           
 ce70:  b2 ...                  PRINT           " You can hear the sound of flowing water from below."
 ce8b:  bb                      NEW_LINE        
 ce8c:  b0                      RTRUE           

Routine ce8e, 4 locals (0000, 0000, 0000, 0000)

 ce97:  a0 4e 46                JZ              G3e [FALSE] ce9e
 ce9a:  41 10 be c0             JE              G00,#be [TRUE] RFALSE
 ce9e:  a0 2f 03 6e             JZ              G1f [FALSE] d20e
 cea2:  a0 4e 00 e3             JZ              G3e [FALSE] cf87
 cea6:  a0 01 00 df             JZ              L00 [FALSE] cf87
 ceaa:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 ceae:  23 1e 00 00 d6          JG              #1e,(SP)+ [FALSE] cf87
 ceb3:  06 71 72 00 73          JIN             "stiletto","thief" [FALSE] cf29
 ceb8:  0c 72 07                CLEAR_ATTR      "thief",#07
 cebb:  b2 ...                  PRINT           "Someone carrying a large bag is casually leaning against one of the walls here. He does not speak, but it is clear from his aspect that the bag will be taken only over his dead body."
 cf24:  bb                      NEW_LINE        
 cf25:  0d 2f 01                STORE           G1f,#01
 cf28:  b0                      RTRUE           
 cf29:  26 71 7f 40             JIN             "stiletto",G6f [FALSE] RFALSE
 cf2d:  0e 71 72                INSERT_OBJ      "stiletto","thief"
 cf30:  0b 71 0e                SET_ATTR        "stiletto",#0e
 cf33:  0c 72 07                CLEAR_ATTR      "thief",#07
 cf36:  b2 ...                  PRINT           "You feel a light finger-touch, and turning, notice a grinning figure holding a large bag in one hand and a stiletto in the other."
 cf83:  0d 2f 01                STORE           G1f,#01
 cf86:  b0                      RTRUE           
 cf87:  a0 01 80 93             JZ              L00 [TRUE] d01c
 cf8b:  0a 72 02 00 8e          TEST_ATTR       "thief",#02 [FALSE] d01c
 cf90:  e0 1f 7f c2 72 00       CALL            ff84 (#72) -> -(SP)
 cf96:  a0 00 00 84             JZ              (SP)+ [FALSE] d01c
 cf9a:  b2 ...                  PRINT           "Your opponent, determining discretion to be the better part of valor, decides to terminate this little contretemps. With a rueful nod of his head, he steps backward into the gloom and disappears."
 d00f:  bb                      NEW_LINE        
 d010:  0b 72 07                SET_ATTR        "thief",#07
 d013:  0c 72 02                CLEAR_ATTR      "thief",#02
 d016:  e0 3f 81 9e 00          CALL            1033c -> -(SP)
 d01b:  b0                      RTRUE           
 d01c:  a0 01 ce                JZ              L00 [TRUE] d02b
 d01f:  0a 72 02 4a             TEST_ATTR       "thief",#02 [FALSE] d02b
 d023:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 d027:  23 5a 00 c0             JG              #5a,(SP)+ [TRUE] RFALSE
 d02b:  a0 01 80 41             JZ              L00 [TRUE] d06e
 d02f:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 d033:  23 1e 00 79             JG              #1e,(SP)+ [FALSE] d06e
 d037:  b2 ...                  PRINT           "The holder of the large bag just left, looking disgusted. Fortunately, he took nothing."
 d064:  bb                      NEW_LINE        
 d065:  0b 72 07                SET_ATTR        "thief",#07
 d068:  e0 3f 81 9e 00          CALL            1033c -> -(SP)
 d06d:  b0                      RTRUE           
 d06e:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 d072:  23 46 00 c0             JG              #46,(SP)+ [TRUE] RFALSE
 d076:  a0 4e 40                JZ              G3e [FALSE] RFALSE
 d079:  e0 25 81 dc 10 72 64 00 CALL            103b8 (G00,#72,#64) -> -(SP)
 d081:  a0 00 c8                JZ              (SP)+ [TRUE] d08a
 d084:  0d 02 01                STORE           L01,#01
 d087:  8c 00 12                JUMP            d09a
 d08a:  e0 27 81 dc 7f 72 00    CALL            103b8 (G6f,#72) -> -(SP)
 d091:  a0 00 c8                JZ              (SP)+ [TRUE] d09a
 d094:  0d 02 01                STORE           L01,#01
 d097:  0d 03 01                STORE           L02,#01
 d09a:  0d 2f 01                STORE           G1f,#01
 d09d:  a0 02 80 8e             JZ              L01 [TRUE] d12d
 d0a1:  a0 01 00 8a             JZ              L00 [FALSE] d12d
 d0a5:  b2 ...                  PRINT           "A seedy-looking individual with a large bag just wandered through the room. On the way through, he quietly abstracted some valuables from the room and from your possession, mumbling something about "Doing unto others before...""
 d126:  bb                      NEW_LINE        
 d127:  e0 3f 69 56 00          CALL            d2ac -> -(SP)
 d12c:  b1                      RFALSE          
 d12d:  a0 01 80 94             JZ              L00 [TRUE] d1c3
 d131:  e0 3f 81 9e 00          CALL            1033c -> -(SP)
 d136:  a0 02 80 64             JZ              L01 [TRUE] d19c
 d13a:  b2 ...                  PRINT           "The thief just left, still carrying his large bag. You may not have noticed that he "
 d165:  a0 03 d6                JZ              L02 [TRUE] d17c
 d168:  b2 ...                  PRINT           "robbed you blind first."
 d179:  8c 00 19                JUMP            d193
 d17c:  b2 ...                  PRINT           "appropriated the valuables in the room."
 d193:  bb                      NEW_LINE        
 d194:  e0 3f 69 56 00          CALL            d2ac -> -(SP)
 d199:  8c 00 22                JUMP            d1bc
 d19c:  b2 ...                  PRINT           "The thief, finding nothing of value, left disgusted."
 d1bb:  bb                      NEW_LINE        
 d1bc:  0b 72 07                SET_ATTR        "thief",#07
 d1bf:  0d 01 00                STORE           L00,#00
 d1c2:  b0                      RTRUE           
 d1c3:  b3 ...                  PRINT_RET       "A "lean and hungry" gentleman just wandered through, carrying a large bag. Finding nothing of value, he left disgruntled."
 d20e:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 d211:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 d215:  23 1e 00 40             JG              #1e,(SP)+ [FALSE] RFALSE
 d219:  e0 25 81 dc 10 72 64 00 CALL            103b8 (G00,#72,#64) -> -(SP)
 d221:  e9 7f 04                PULL            L03
 d224:  a0 04 c8                JZ              L03 [TRUE] d22d
 d227:  e8 bf 04                PUSH            L03
 d22a:  8c 00 09                JUMP            d234
 d22d:  e0 27 81 dc 7f 72 00    CALL            103b8 (G6f,#72) -> -(SP)
 d234:  e9 7f 02                PULL            L01
 d237:  a0 02 80 46             JZ              L01 [TRUE] d27f
 d23b:  b2 ...                  PRINT           "The thief just left, still carrying his large bag. You may not have noticed that he robbed you blind first."
 d276:  bb                      NEW_LINE        
 d277:  e0 3f 69 56 00          CALL            d2ac -> -(SP)
 d27c:  8c 00 22                JUMP            d29f
 d27f:  b2 ...                  PRINT           "The thief, finding nothing of value, left disgusted."
 d29e:  bb                      NEW_LINE        
 d29f:  0b 72 07                SET_ATTR        "thief",#07
 d2a2:  0d 01 00                STORE           L00,#00
 d2a5:  e0 3f 81 9e 00          CALL            1033c -> -(SP)
 d2aa:  b1                      RFALSE          

Routine d2ac, 1 local (0000)

 d2af:  2d 01 52                STORE           L00,G42
 d2b2:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 d2b8:  a0 52 41                JZ              G42 [FALSE] RTRUE
 d2bb:  a0 01 c1                JZ              L00 [TRUE] RTRUE
 d2be:  b3 ...                  PRINT_RET       "The thief seems to have left you in the dark."

Routine d2d2, 1 local (0000)

 d2d5:  e0 3f 81 9e 00          CALL            1033c -> -(SP)
 d2da:  0b 72 07                SET_ATTR        "thief",#07
 d2dd:  92 be 01 c2             GET_CHILD       "Treasure Room" -> L00 [TRUE] d2e1
 d2e1:  a0 01 c1                JZ              L00 [TRUE] RTRUE
 d2e4:  4c 01 07                CLEAR_ATTR      L00,#07
 d2e7:  a1 01 01 c2             GET_SIBLING     L00 -> L00 [TRUE] d2eb
 d2eb:  8c ff f5                JUMP            d2e1

Routine d2ee, 4 locals (0000, 0000, 0000, 0000)

 d2f7:  92 72 02 c2             GET_CHILD       "thief" -> L01 [TRUE] d2fb
 d2fb:  a0 02 44                JZ              L01 [FALSE] d300
 d2fe:  ab 04                   RET             L03
 d300:  a1 02 03 c2             GET_SIBLING     L01 -> L02 [TRUE] d304
 d304:  c1 97 02 71 73 45       JE              L01,#71,#73 [FALSE] d30d
 d30a:  8c 00 1a                JUMP            d325
 d30d:  51 02 0c 00             GET_PROP        L01,#0c -> -(SP)
 d311:  43 00 00 52             JG              (SP)+,#00 [FALSE] d325
 d315:  6e 02 01                INSERT_OBJ      L01,L00
 d318:  0d 04 01                STORE           L03,#01
 d31b:  41 02 57 48             JE              L01,#57 [FALSE] d325
 d31f:  0d 30 01                STORE           G20,#01
 d322:  0b 57 0b                SET_ATTR        "jewel-encrusted egg",#0b
 d325:  2d 02 03                STORE           L01,L02
 d328:  8c ff d2                JUMP            d2fb

Routine d32c, 3 locals (0000, 0000, 0000)

 d333:  a2 01 02 c2             GET_CHILD       L00 -> L01 [TRUE] d337
 d337:  a0 02 c0                JZ              L01 [TRUE] RFALSE
 d33a:  a1 02 03 c2             GET_SIBLING     L01 -> L02 [TRUE] d33e
 d33e:  4a 02 11 00 60          TEST_ATTR       L01,#11 [FALSE] d3a1
 d343:  4a 02 07 80 5b          TEST_ATTR       L01,#07 [TRUE] d3a1
 d348:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 d34c:  23 28 00 00 52          JG              #28,(SP)+ [FALSE] d3a1
 d351:  b2 ...                  PRINT           "You hear, off in the distance, someone saying "My, I wonder what this fine "
 d380:  aa 02                   PRINT_OBJ       L01
 d382:  b2 ...                  PRINT           " is doing here.""
 d38d:  bb                      NEW_LINE        
 d38e:  e0 1f 27 21 3c 00       CALL            4e42 (#3c) -> -(SP)
 d394:  a0 00 c1                JZ              (SP)+ [TRUE] RTRUE
 d397:  4e 02 72                INSERT_OBJ      L01,"thief"
 d39a:  4b 02 03                SET_ATTR        L01,#03
 d39d:  4b 02 07                SET_ATTR        L01,#07
 d3a0:  b0                      RTRUE           
 d3a1:  2d 02 03                STORE           L01,L02
 d3a4:  8c ff 92                JUMP            d337

Routine d3a8, 4 locals (0000, 0000, 0000, 0000)

 d3b1:  41 88 6f 5d             JE              G78,#6f [FALSE] d3d0
 d3b5:  b2 ...                  PRINT           "The thief is a strong, silent type."
 d3ca:  bb                      NEW_LINE        
 d3cb:  0d 7c 00                STORE           G6c,#00
 d3ce:  ab 7c                   RET             G6c
 d3d0:  a0 01 02 ea             JZ              L00 [FALSE] d6bc
 d3d4:  41 88 42 00 50          JE              G78,#42 [FALSE] d427
 d3d9:  11 72 0b 00             GET_PROP        "thief",#0b -> -(SP)
 d3dd:  61 00 2c 00 47          JE              (SP)+,G1c [FALSE] d427
 d3e2:  b3 ...                  PRINT_RET       "The thief, being temporarily incapacitated, is unable to acknowledge your greeting with his usual graciousness."
 d427:  41 86 a9 00 d6          JE              G76,#a9 [FALSE] d500
 d42c:  41 88 7f 00 d1          JE              G78,#7f [FALSE] d500
 d431:  0a 72 02 80 cc          TEST_ATTR       "thief",#02 [TRUE] d500
 d436:  e0 1f 27 21 0a 00       CALL            4e42 (#0a) -> -(SP)
 d43c:  a0 00 80 62             JZ              (SP)+ [TRUE] d4a0
 d440:  b2 ...                  PRINT           "You evidently frightened the robber, though you didn't hit him. He flees"
 d46f:  92 72 03 67             GET_CHILD       "thief" -> L02 [FALSE] d498
 d473:  e0 1b 6c a3 72 10 00    CALL            d946 (#72,G00) -> -(SP)
 d47a:  b2 ...                  PRINT           ", but the contents of his bag fall on the floor."
 d495:  8c 00 05                JUMP            d49b
 d498:  b2 ...                  PRINT           "."
 d49b:  bb                      NEW_LINE        
 d49c:  0b 72 07                SET_ATTR        "thief",#07
 d49f:  b0                      RTRUE           
 d4a0:  b2 ...                  PRINT           "You missed. The thief makes no attempt to take the knife, though it would be a fine addition to the collection in his bag. He does seem angered by your attempt."
 d4fb:  bb                      NEW_LINE        
 d4fc:  0b 72 02                SET_ATTR        "thief",#02
 d4ff:  b0                      RTRUE           
 d500:  c1 97 88 3f 7f 00 d1    JE              G78,#3f,#7f [FALSE] d5d6
 d507:  a0 86 80 cd             JZ              G76 [TRUE] d5d6
 d50b:  41 86 72 80 c8          JE              G76,#72 [TRUE] d5d6
 d510:  41 87 72 00 c3          JE              G77,#72 [FALSE] d5d6
 d515:  11 72 07 00             GET_PROP        "thief",#07 -> -(SP)
 d519:  42 00 00 00 49          JL              (SP)+,#00 [FALSE] d565
 d51e:  11 72 07 00             GET_PROP        "thief",#07 -> -(SP)
 d522:  35 00 00 00             SUB             #00,(SP)+ -> -(SP)
 d526:  e3 5b 72 07 00          PUT_PROP        "thief",#07,(SP)+
 d52b:  e0 0f 2a 43 80 f0 00    CALL            5486 (#80f0) -> -(SP)
 d532:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 d537:  e0 3f 81 9e 00          CALL            1033c -> -(SP)
 d53c:  e3 5b 72 0b 2d          PUT_PROP        "thief",#0b,G1d
 d541:  b2 ...                  PRINT           "Your proposed victim suddenly recovers consciousness."
 d564:  bb                      NEW_LINE        
 d565:  4e 86 72                INSERT_OBJ      G76,"thief"
 d568:  51 86 0c 00             GET_PROP        G76,#0c -> -(SP)
 d56c:  43 00 00 00 45          JG              (SP)+,#00 [FALSE] d5b4
 d571:  0d 2e 01                STORE           G1e,#01
 d574:  b2 ...                  PRINT           "The thief is taken aback by your unexpected generosity, but accepts the "
 d59d:  aa 86                   PRINT_OBJ       G76
 d59f:  b3 ...                  PRINT_RET       " and stops to admire its beauty."
 d5b4:  b2 ...                  PRINT           "The thief places the "
 d5bf:  aa 86                   PRINT_OBJ       G76
 d5c1:  b3 ...                  PRINT_RET       " in his bag and thanks you politely."
 d5d6:  41 88 5d 5b             JE              G78,#5d [FALSE] d5f3
 d5da:  b3 ...                  PRINT_RET       "Once you got him, what would you do with him?"
 d5f3:  c1 97 88 39 38 00 9b    JE              G78,#39,#38 [FALSE] d693
 d5fa:  b3 ...                  PRINT_RET       "The thief is a slippery character with beady eyes that flit back and forth. He carries, along with an unmistakable arrogance, a large bag over his shoulder and a vicious stiletto, whose blade is aimed menacingly in your direction. I'd watch out if I were you."
 d693:  41 88 4d 40             JE              G78,#4d [FALSE] RFALSE
 d697:  b3 ...                  PRINT_RET       "The thief says nothing, as you have not been formally introduced."
 d6bc:  41 01 01 00 4e          JE              L00,#01 [FALSE] d70d
 d6c1:  06 71 72 c0             JIN             "stiletto","thief" [TRUE] RFALSE
 d6c5:  93 72 00                GET_PARENT      "thief" -> -(SP)
 d6c8:  26 71 00 40             JIN             "stiletto",(SP)+ [FALSE] RFALSE
 d6cc:  0e 71 72                INSERT_OBJ      "stiletto","thief"
 d6cf:  0b 71 0e                SET_ATTR        "stiletto",#0e
 d6d2:  26 72 10 41             JIN             "thief",G00 [FALSE] RTRUE
 d6d6:  b2 ...                  PRINT           "The robber, somewhat surprised at this turn of events, nimbly retrieves his stiletto."
 d70b:  bb                      NEW_LINE        
 d70c:  b0                      RTRUE           
 d70d:  41 01 02 00 bb          JE              L00,#02 [FALSE] d7cb
 d712:  2e 71 10                INSERT_OBJ      "stiletto",G00
 d715:  0c 71 0e                CLEAR_ATTR      "stiletto",#0e
 d718:  e0 2f 69 77 10 03       CALL            d2ee (G00) -> L02
 d71e:  41 10 be 00 8a          JE              G00,#be [FALSE] d7ab
 d723:  a2 10 03 c2             GET_CHILD       G00 -> L02 [TRUE] d727
 d727:  a0 03 5b                JZ              L02 [FALSE] d743
 d72a:  b2 ...                  PRINT           "The chalice is now safe to take."
 d73f:  bb                      NEW_LINE        
 d740:  8c 00 7d                JUMP            d7be
 d743:  c1 95 03 bf 72 04 80 5b JE              L02,#bf,#72,#04 [TRUE] d7a4
 d74b:  4c 03 07                CLEAR_ATTR      L02,#07
 d74e:  a0 02 75                JZ              L01 [FALSE] d784
 d751:  0d 02 01                STORE           L01,#01
 d754:  b2 ...                  PRINT           "As the thief dies, the power of his magic decreases, and his treasures reappear:"
 d783:  bb                      NEW_LINE        
 d784:  b2 ...                  PRINT           "  A "
 d789:  aa 03                   PRINT_OBJ       L02
 d78b:  a2 03 00 56             GET_CHILD       L02 -> -(SP) [FALSE] d7a3
 d78f:  e0 2f 48 29 03 00       CALL            9052 (L02) -> -(SP)
 d795:  a0 00 cd                JZ              (SP)+ [TRUE] d7a3
 d798:  b2 ...                  PRINT           ", with "
 d79d:  e0 2f 47 2c 03 00       CALL            8e58 (L02) -> -(SP)
 d7a3:  bb                      NEW_LINE        
 d7a4:  a1 03 03 c2             GET_SIBLING     L02 -> L02 [TRUE] d7a8
 d7a8:  8c ff 7e                JUMP            d727
 d7ab:  a0 03 d2                JZ              L02 [TRUE] d7be
 d7ae:  b2 ...                  PRINT           "His booty remains."
 d7bd:  bb                      NEW_LINE        
 d7be:  e0 0f 2a 43 80 f0 00    CALL            5486 (#80f0) -> -(SP)
 d7c5:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 d7ca:  b0                      RTRUE           
 d7cb:  41 01 05 58             JE              L00,#05 [FALSE] d7e5
 d7cf:  a0 2f c0                JZ              G1f [TRUE] RFALSE
 d7d2:  0a 72 07 c0             TEST_ATTR       "thief",#07 [TRUE] RFALSE
 d7d6:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 d7da:  23 14 00 40             JG              #14,(SP)+ [FALSE] RFALSE
 d7de:  0b 72 02                SET_ATTR        "thief",#02
 d7e1:  0d 7c 00                STORE           G6c,#00
 d7e4:  b0                      RTRUE           
 d7e5:  41 01 03 5d             JE              L00,#03 [FALSE] d804
 d7e9:  e0 0f 2a 43 80 f0 00    CALL            5486 (#80f0) -> -(SP)
 d7f0:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 d7f5:  0c 72 02                CLEAR_ATTR      "thief",#02
 d7f8:  2e 71 10                INSERT_OBJ      "stiletto",G00
 d7fb:  0c 71 0e                CLEAR_ATTR      "stiletto",#0e
 d7fe:  e3 5b 72 0b 2c          PUT_PROP        "thief",#0b,G1c
 d803:  b0                      RTRUE           
 d804:  41 01 04 40             JE              L00,#04 [FALSE] RFALSE
 d808:  93 72 00                GET_PARENT      "thief" -> -(SP)
 d80b:  61 00 10 00 53          JE              (SP)+,G00 [FALSE] d861
 d810:  0b 72 02                SET_ATTR        "thief",#02
 d813:  b2 ...                  PRINT           "The robber revives, briefly feigning continued unconsciousness, and, when he sees his moment, scrambles away from you."
 d860:  bb                      NEW_LINE        
 d861:  e0 0f 2a 43 80 f0 00    CALL            5486 (#80f0) -> -(SP)
 d868:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 d86d:  e3 5b 72 0b 2d          PUT_PROP        "thief",#0b,G1d
 d872:  e0 3f 81 9e 00          CALL            1033c -> -(SP)
 d877:  b8                      RET_POPPED      

Routine d878, 0 locals ()

 d879:  41 88 5d 00 58          JE              G78,#5d [FALSE] d8d4
 d87e:  11 72 0b 00             GET_PROP        "thief",#0b -> -(SP)
 d882:  61 00 2c 77             JE              (SP)+,G1c [FALSE] d8bb
 d886:  b3 ...                  PRINT_RET       "Sadly for you, the robber collapsed on top of the bag. Trying to take it would wake him."
 d8bb:  b3 ...                  PRINT_RET       "The bag will be taken over his dead body."
 d8d4:  41 88 12 55             JE              G78,#12 [FALSE] d8eb
 d8d8:  41 87 73 51             JE              G77,#73 [FALSE] d8eb
 d8dc:  b3 ...                  PRINT_RET       "It would be a good trick."
 d8eb:  c1 97 88 23 2b 5f       JE              G78,#23,#2b [FALSE] d90e
 d8f1:  b3 ...                  PRINT_RET       "Getting close enough would be a good trick."
 d90e:  c1 97 88 39 38 40       JE              G78,#39,#38 [FALSE] RFALSE
 d914:  b3 ...                  PRINT_RET       "The bag is underneath the thief, so one can't say what, if anything, is inside."

Routine d946, 4 locals (0000, 0000, 0000, 0000)

 d94f:  a2 01 03 40             GET_CHILD       L00 -> L02 [FALSE] RFALSE
 d953:  a0 03 c1                JZ              L02 [TRUE] RTRUE
 d956:  a1 03 04 c2             GET_SIBLING     L02 -> L03 [TRUE] d95a
 d95a:  4c 03 07                CLEAR_ATTR      L02,#07
 d95d:  6e 03 02                INSERT_OBJ      L02,L01
 d960:  2d 03 04                STORE           L02,L03
 d963:  8c ff ef                JUMP            d953

Routine d966, 0 locals ()

 d967:  41 88 5d 73             JE              G78,#5d [FALSE] d99c
 d96b:  46 86 be 40             JIN             G76,"Treasure Room" [FALSE] RFALSE
 d96f:  06 72 be 40             JIN             "thief","Treasure Room" [FALSE] RFALSE
 d973:  0a 72 02 40             TEST_ATTR       "thief",#02 [FALSE] RFALSE
 d977:  0a 72 07 c0             TEST_ATTR       "thief",#07 [TRUE] RFALSE
 d97b:  11 72 0b 00             GET_PROP        "thief",#0b -> -(SP)
 d97f:  61 00 2c c0             JE              (SP)+,G1c [TRUE] RFALSE
 d983:  b3 ...                  PRINT_RET       "You'd be stabbed in the back first."
 d99c:  41 88 12 63             JE              G78,#12 [FALSE] d9c1
 d9a0:  41 87 bf 5f             JE              G77,#bf [FALSE] d9c1
 d9a4:  b3 ...                  PRINT_RET       "You can't. It's not a very good chalice, is it?"
 d9c1:  e0 3f 85 1f 00          CALL            10a3e -> -(SP)
 d9c6:  b8                      RET_POPPED      

Routine d9c8, 3 locals (0000, 0000, 0000)

 d9cf:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
 d9d3:  e0 0f 2a 43 80 f0 00    CALL            5486 (#80f0) -> -(SP)
 d9da:  4f 00 00 00             LOADW           (SP)+,#00 -> -(SP)
 d9de:  41 00 01 40             JE              (SP)+,#01 [FALSE] RFALSE
 d9e2:  a0 4e 40                JZ              G3e [FALSE] RFALSE
 d9e5:  26 72 10 c8             JIN             "thief",G00 [TRUE] d9ef
 d9e9:  e8 7f 01                PUSH            #01
 d9ec:  8c 00 05                JUMP            d9f2
 d9ef:  e8 7f 00                PUSH            #00
 d9f2:  2d 02 00                STORE           L01,(SP)+
 d9f5:  a0 02 80 5a             JZ              L01 [TRUE] da51
 d9f9:  b2 ...                  PRINT           "You hear a scream of anguish as you violate the robber's hideaway. Using passages unknown to you, he rushes to its defense."
 da44:  bb                      NEW_LINE        
 da45:  2e 72 10                INSERT_OBJ      "thief",G00
 da48:  0b 72 02                SET_ATTR        "thief",#02
 da4b:  0c 72 07                CLEAR_ATTR      "thief",#07
 da4e:  8c 00 05                JUMP            da54
 da51:  0b 72 02                SET_ATTR        "thief",#02
 da54:  e0 3f 6d 2d 00          CALL            da5a -> -(SP)
 da59:  b8                      RET_POPPED      

Routine da5a, 2 locals (0000, 0000)

 da5f:  a2 10 01 c2             GET_CHILD       G00 -> L00 [TRUE] da63
 da63:  a0 01 f5                JZ              L00 [TRUE] da99
 da66:  a1 01 00 71             GET_SIBLING     L00 -> -(SP) [FALSE] da99
 da6a:  b2 ...                  PRINT           "The thief gestures mysteriously, and the treasures in the room suddenly vanish."
 da97:  bb                      NEW_LINE        
 da98:  bb                      NEW_LINE        
 da99:  a0 01 c1                JZ              L00 [TRUE] RTRUE
 da9c:  41 01 bf c9             JE              L00,#bf [TRUE] daa7
 daa0:  41 01 72 c5             JE              L00,#72 [TRUE] daa7
 daa4:  4b 01 07                SET_ATTR        L00,#07
 daa7:  a1 01 01 c2             GET_SIBLING     L00 -> L00 [TRUE] daab
 daab:  8c ff ed                JUMP            da99

Routine daae, 0 locals ()

 daaf:  41 88 2b 4f             JE              G78,#2b [FALSE] dac0
 dab3:  b3 ...                  PRINT_RET       "The door cannot be opened."
 dac0:  41 88 1c 4f             JE              G78,#1c [FALSE] dad1
 dac4:  b3 ...                  PRINT_RET       "You cannot burn this door."
 dad1:  41 88 2a 55             JE              G78,#2a [FALSE] dae8
 dad5:  b3 ...                  PRINT_RET       "You can't seem to damage the door."
 dae8:  41 88 52 40             JE              G78,#52 [FALSE] RFALSE
 daec:  b3 ...                  PRINT_RET       "It won't open."

Routine daf6, 0 locals ()

 daf7:  41 88 5d 5b             JE              G78,#5d [FALSE] db14
 dafb:  b3 ...                  PRINT_RET       "A force keeps you from taking the bodies."
 db14:  c1 97 88 1c 2a 40       JE              G78,#1c,#2a [FALSE] RFALSE
 db1a:  e0 0f 83 33 9e 2f 00    CALL            10666 (S238) -> -(SP)
 db21:  b8                      RET_POPPED      

Routine db22, 0 locals ()

 db23:  41 88 2b 59             JE              G78,#2b [FALSE] db3e
 db27:  b3 ...                  PRINT_RET       "The book is already open to page 569."
 db3e:  41 88 23 5b             JE              G78,#23 [FALSE] db5b
 db42:  b3 ...                  PRINT_RET       "As hard as you try, the book cannot be closed."
 db5b:  41 88 59 d3             JE              G78,#59 [TRUE] db70
 db5f:  41 88 6b 00 99          JE              G78,#6b [FALSE] dbfb
 db64:  41 87 0e 00 94          JE              G77,#0e [FALSE] dbfb
 db69:  c1 8f 6e 02 39 80 8d    JE              G5e,#0239 [TRUE] dbfb
 db70:  b3 ...                  PRINT_RET       "Beside page 569, there is only one other page with any legible printing on it. Most of it is unreadable, but the subject seems to be the banishment of evil. Apparently, certain noises, lights, and prayers are efficacious in this regard."
 dbfb:  41 88 1c 40             JE              G78,#1c [FALSE] RFALSE
 dbff:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 dc05:  e0 0f 83 33 9e 57 00    CALL            10666 (S239) -> -(SP)
 dc0c:  b8                      RET_POPPED      

Routine dc0e, 0 locals ()

 dc0f:  41 88 2a 40             JE              G78,#2a [FALSE] RFALSE
 dc13:  e3 97 86 0c 00          PUT_PROP        G76,#0c,#00
 dc18:  e3 93 86 0b 9e 7a       PUT_PROP        G76,#0b,S240
 dc1e:  b3 ...                  PRINT_RET       "Congratulations! Unlike the other vandals, who merely stole the artist's masterpieces, you have destroyed one."

Routine dc64, 0 locals ()

 dc65:  41 88 7f 7c             JE              G78,#7f [FALSE] dca3
 dc69:  b2 ...                  PRINT           "The lamp has smashed into the floor, and the light has gone out."
 dc8c:  bb                      NEW_LINE        
 dc8d:  e0 0f 2a 43 6f 55 00    CALL            5486 (#6f55) -> -(SP)
 dc94:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 dc99:  e0 1f 3c 5d a4 00       CALL            78ba (#a4) -> -(SP)
 dc9f:  2e d2 10                INSERT_OBJ      "broken lantern",G00
 dca2:  b0                      RTRUE           
 dca3:  41 88 0e 66             JE              G78,#0e [FALSE] dccb
 dca7:  0a a4 12 55             TEST_ATTR       "brass lantern",#12 [FALSE] dcbe
 dcab:  b3 ...                  PRINT_RET       "A burned-out lamp won't light."
 dcbe:  e0 0f 2a 43 6f 55 00    CALL            5486 (#6f55) -> -(SP)
 dcc5:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 dcca:  b1                      RFALSE          
 dccb:  41 88 16 64             JE              G78,#16 [FALSE] dcf1
 dccf:  0a a4 12 53             TEST_ATTR       "brass lantern",#12 [FALSE] dce4
 dcd3:  b3 ...                  PRINT_RET       "The lamp has already burned out."
 dce4:  e0 0f 2a 43 6f 55 00    CALL            5486 (#6f55) -> -(SP)
 dceb:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 dcf0:  b1                      RFALSE          
 dcf1:  41 88 38 40             JE              G78,#38 [FALSE] RFALSE
 dcf5:  b2 ...                  PRINT           "The lamp "
 dcfc:  0a a4 12 50             TEST_ATTR       "brass lantern",#12 [FALSE] dd0e
 dd00:  b2 ...                  PRINT           "has burned out."
 dd0b:  8c 00 19                JUMP            dd25
 dd0e:  0a a4 14 4a             TEST_ATTR       "brass lantern",#14 [FALSE] dd1a
 dd12:  b2 ...                  PRINT           "is on."
 dd17:  8c 00 0d                JUMP            dd25
 dd1a:  b2 ...                  PRINT           "is turned off."
 dd25:  bb                      NEW_LINE        
 dd26:  b0                      RTRUE           

Routine dd28, 0 locals ()

 dd29:  41 88 5d 40             JE              G78,#5d [FALSE] RFALSE
 dd2d:  41 86 a0 40             JE              G76,#a0 [FALSE] RFALSE
 dd31:  b3 ...                  PRINT_RET       "It is securely anchored."

Routine dd42, 1 local (0000)

 dd45:  c1 97 88 1c 0e 00 88    JE              G78,#1c,#0e [FALSE] ddd2
 dd4c:  41 86 9b 00 83          JE              G76,#9b [FALSE] ddd2
 dd51:  43 2a 00 44             JG              G1a,#00 [FALSE] dd57
 dd55:  96 2a                   DEC             G1a
 dd57:  43 2a 00 dd             JG              G1a,#00 [TRUE] dd76
 dd5b:  b3 ...                  PRINT_RET       "I'm afraid that you have run out of matches."
 dd76:  c1 97 10 e4 ce 61       JE              G00,#e4,#ce [FALSE] dd9b
 dd7c:  b3 ...                  PRINT_RET       "This room is drafty, and the match goes out instantly."
 dd9b:  0b 9b 19                SET_ATTR        "matchbook",#19
 dd9e:  0b 9b 14                SET_ATTR        "matchbook",#14
 dda1:  e0 07 2a 39 6f 46 02 00 CALL            5472 (#6f46,#02) -> -(SP)
 dda9:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 ddae:  b2 ...                  PRINT           "One of the matches starts to burn."
 ddc5:  bb                      NEW_LINE        
 ddc6:  a0 52 41                JZ              G42 [FALSE] RTRUE
 ddc9:  0d 52 01                STORE           G42,#01
 ddcc:  e0 3f 3f 02 00          CALL            7e04 -> -(SP)
 ddd1:  b0                      RTRUE           
 ddd2:  41 88 16 7a             JE              G78,#16 [FALSE] de0e
 ddd6:  0a 9b 19 76             TEST_ATTR       "matchbook",#19 [FALSE] de0e
 ddda:  b2 ...                  PRINT           "The match is out."
 dde5:  bb                      NEW_LINE        
 dde6:  0c 9b 19                CLEAR_ATTR      "matchbook",#19
 dde9:  0c 9b 14                CLEAR_ATTR      "matchbook",#14
 ddec:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 ddf2:  a0 52 52                JZ              G42 [FALSE] de05
 ddf5:  b2 ...                  PRINT           "It's pitch black in here!"
 de04:  bb                      NEW_LINE        
 de05:  e0 07 2a 39 6f 46 00 00 CALL            5472 (#6f46,#00) -> -(SP)
 de0d:  b0                      RTRUE           
 de0e:  c1 97 88 2b 25 6e       JE              G78,#2b,#25 [FALSE] de40
 de14:  b2 ...                  PRINT           "You have "
 de19:  55 2a 01 01             SUB             G1a,#01 -> L00
 de1d:  43 01 00 c8             JG              L00,#00 [TRUE] de27
 de21:  b2 ...                  PRINT           "no"
 de24:  8c 00 05                JUMP            de2a
 de27:  e6 bf 01                PRINT_NUM       L00
 de2a:  b2 ...                  PRINT           " match"
 de2f:  41 01 01 ca             JE              L00,#01 [TRUE] de3b
 de33:  b2 ...                  PRINT           "es."
 de38:  8c 00 05                JUMP            de3e
 de3b:  b2 ...                  PRINT           "."
 de3e:  bb                      NEW_LINE        
 de3f:  b0                      RTRUE           
 de40:  41 88 38 40             JE              G78,#38 [FALSE] RFALSE
 de44:  0a 9b 14 54             TEST_ATTR       "matchbook",#14 [FALSE] de5a
 de48:  b2 ...                  PRINT           "The match is burning."
 de57:  8c 00 31                JUMP            de89
 de5a:  b2 ...                  PRINT           "The matchbook isn't very interesting, except for what's written on it."
 de89:  bb                      NEW_LINE        
 de8a:  b0                      RTRUE           

Routine de8c, 0 locals ()

 de8d:  b2 ...                  PRINT           "The match has gone out."
 de9c:  bb                      NEW_LINE        
 de9d:  0c 9b 19                CLEAR_ATTR      "matchbook",#19
 dea0:  0c 9b 14                CLEAR_ATTR      "matchbook",#14
 dea3:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 dea9:  b0                      RTRUE           

Routine deaa, 2 locals (0000, 0000)

 deaf:  9e 2b 02                LOAD            G1b -> L01
 deb2:  4f 02 00 01             LOADW           L01,#00 -> L00
 deb6:  e0 0b 2a 39 6f 55 01 00 CALL            5472 (#6f55,L00) -> -(SP)
 debe:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 dec3:  e0 1a 6f 81 a4 02 01 00 CALL            df02 (#a4,L01,L00) -> -(SP)
 decb:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 dece:  54 02 04 2b             ADD             L01,#04 -> G1b
 ded2:  ab 2b                   RET             G1b

Routine ded4, 2 locals (0000, 0000)

 ded9:  9e 29 02                LOAD            G19 -> L01
 dedc:  0b 93 03                SET_ATTR        "pair of candles",#03
 dedf:  4f 02 00 01             LOADW           L01,#00 -> L00
 dee3:  e0 0b 2a 39 6f 6a 01 00 CALL            5472 (#6f6a,L00) -> -(SP)
 deeb:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 def0:  e0 1a 6f 81 93 02 01 00 CALL            df02 (#93,L01,L00) -> -(SP)
 def8:  a0 01 c0                JZ              L00 [TRUE] RFALSE
 defb:  54 02 04 29             ADD             L01,#04 -> G19
 deff:  ab 29                   RET             G19

Routine df02, 3 locals (0000, 0000, 0000)

 df09:  a0 03 48                JZ              L02 [FALSE] df12
 df0c:  4c 01 14                CLEAR_ATTR      L00,#14
 df0f:  4b 01 12                SET_ATTR        L00,#12
 df12:  e0 2f 4a 76 01 00       CALL            94ec (L00) -> -(SP)
 df18:  a0 00 46                JZ              (SP)+ [FALSE] df1f
 df1b:  66 01 10 40             JIN             L00,G00 [FALSE] RFALSE
 df1f:  a0 03 60                JZ              L02 [FALSE] df40
 df22:  b2 ...                  PRINT           "You'd better have more light than from the "
 df3b:  aa 01                   PRINT_OBJ       L00
 df3d:  b3 ...                  PRINT_RET       "."
 df40:  4f 02 01 00             LOADW           L01,#01 -> -(SP)
 df44:  ad 00                   PRINT_PADDR     (SP)+
 df46:  bb                      NEW_LINE        
 df47:  b0                      RTRUE           

Routine df48, 2 locals (0000, 0000)

 df4d:  62 01 02 44             JL              L00,L01 [FALSE] df53
 df51:  ab 01                   RET             L00
 df53:  ab 02                   RET             L01

Routine df56, 0 locals ()

 df57:  0a 93 03 ce             TEST_ATTR       "pair of candles",#03 [TRUE] df67
 df5b:  e0 0f 2a 43 6f 6a 00    CALL            5486 (#6f6a) -> -(SP)
 df62:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 df67:  21 93 87 c0             JE              #93,G77 [TRUE] RFALSE
 df6b:  c1 97 88 1c 0e 01 15    JE              G78,#1c,#0e [FALSE] e085
 df72:  0a 93 12 71             TEST_ATTR       "pair of candles",#12 [FALSE] dfa5
 df76:  b3 ...                  PRINT_RET       "Alas, there's not much left of the candles. Certainly not enough to burn."
 dfa5:  a0 87 79                JZ              G77 [FALSE] dfdf
 dfa8:  0a 9b 19 57             TEST_ATTR       "matchbook",#19 [FALSE] dfc1
 dfac:  b2 ...                  PRINT           "(with the match)"
 dfb7:  bb                      NEW_LINE        
 dfb8:  e0 15 2b be 0e 93 9b 00 CALL            577c (#0e,#93,#9b) -> -(SP)
 dfc0:  b0                      RTRUE           
 dfc1:  b2 ...                  PRINT           "You should say what to light them with."
 dfdc:  bb                      NEW_LINE        
 dfdd:  9b 02                   RET             #02
 dfdf:  41 87 9b 6c             JE              G77,#9b [FALSE] e00d
 dfe3:  0a 9b 14 68             TEST_ATTR       "matchbook",#14 [FALSE] e00d
 dfe7:  b2 ...                  PRINT           "The candles are "
 dfec:  0a 93 14 49             TEST_ATTR       "pair of candles",#14 [FALSE] dff7
 dff0:  b3 ...                  PRINT_RET       "already lit."
 dff7:  0b 93 14                SET_ATTR        "pair of candles",#14
 dffa:  b2 ...                  PRINT           "lit."
 dfff:  bb                      NEW_LINE        
 e000:  e0 0f 2a 43 6f 6a 00    CALL            5486 (#6f6a) -> -(SP)
 e007:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 e00c:  b0                      RTRUE           
 e00d:  41 87 68 00 50          JE              G77,#68 [FALSE] e060
 e012:  0a 93 14 61             TEST_ATTR       "pair of candles",#14 [FALSE] e035
 e016:  b3 ...                  PRINT_RET       "You realize, just in time, that the candles are already lighted."
 e035:  b2 ...                  PRINT           "The heat from the torch is so intense that the candles are vaporized."
 e058:  bb                      NEW_LINE        
 e059:  e0 1f 3c 5d 93 00       CALL            78ba (#93) -> -(SP)
 e05f:  b8                      RET_POPPED      
 e060:  b3 ...                  PRINT_RET       "You have to light them with something that's burning, you know."
 e085:  41 88 25 75             JE              G78,#25 [FALSE] e0bc
 e089:  b3 ...                  PRINT_RET       "Let's see, how many objects in a pair? Don't tell me, I'll get it."
 e0bc:  41 88 16 00 51          JE              G78,#16 [FALSE] e110
 e0c1:  e0 0f 2a 43 6f 6a 00    CALL            5486 (#6f6a) -> -(SP)
 e0c8:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 e0cd:  0a 93 14 74             TEST_ATTR       "pair of candles",#14 [FALSE] e103
 e0d1:  b2 ...                  PRINT           "The flame is extinguished."
 e0e2:  0c 93 14                CLEAR_ATTR      "pair of candles",#14
 e0e5:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 e0eb:  a0 52 55                JZ              G42 [FALSE] e101
 e0ee:  b2 ...                  PRINT           " It's really dark in here...."
 e101:  bb                      NEW_LINE        
 e102:  b0                      RTRUE           
 e103:  b3 ...                  PRINT_RET       "The candles are not lighted."
 e110:  41 88 12 59             JE              G78,#12 [FALSE] e12b
 e114:  4a 87 1a 55             TEST_ATTR       G77,#1a [FALSE] e12b
 e118:  b3 ...                  PRINT_RET       "That wouldn't be smart."
 e12b:  41 88 38 40             JE              G78,#38 [FALSE] RFALSE
 e12f:  b2 ...                  PRINT           "The candles are "
 e134:  0a 93 14 4c             TEST_ATTR       "pair of candles",#14 [FALSE] e142
 e138:  b2 ...                  PRINT           "burning."
 e13f:  8c 00 07                JUMP            e147
 e142:  b2 ...                  PRINT           "out."
 e147:  bb                      NEW_LINE        
 e148:  b0                      RTRUE           

Routine e14a, 1 local (0000)

 e14d:  41 01 06 40             JE              L00,#06 [FALSE] RFALSE
 e151:  26 93 7f 40             JIN             "pair of candles",G6f [FALSE] RFALSE
 e155:  e0 1f 27 21 32 00       CALL            4e42 (#32) -> -(SP)
 e15b:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 e15e:  0a 93 14 40             TEST_ATTR       "pair of candles",#14 [FALSE] RFALSE
 e162:  e0 0f 2a 43 6f 6a 00    CALL            5486 (#6f6a) -> -(SP)
 e169:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 e16e:  0c 93 14                CLEAR_ATTR      "pair of candles",#14
 e171:  b2 ...                  PRINT           "A gust of wind blows out your candles!"
 e188:  bb                      NEW_LINE        
 e189:  e0 2f 36 31 10 52       CALL            6c62 (G00) -> G42
 e18f:  a0 52 40                JZ              G42 [FALSE] RFALSE
 e192:  b3 ...                  PRINT_RET       "It is now completely dark."

Routine e1a6, 1 local (0000)

 e1a9:  41 88 5d 55             JE              G78,#5d [FALSE] e1c0
 e1ad:  41 7f 04 51             JE              G6f,#04 [FALSE] e1c0
 e1b1:  e0 03 2a 39 80 7c ff ff 00 
                               CALL            5472 (#807c,#ffff) -> -(SP)
 e1ba:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 e1bf:  b1                      RFALSE          
 e1c0:  41 88 38 40             JE              G78,#38 [FALSE] RFALSE
 e1c4:  11 6e 0c 01             GET_PROP        "sword",#0c -> L00
 e1c8:  41 01 01 5d             JE              L00,#01 [FALSE] e1e7
 e1cc:  b3 ...                  PRINT_RET       "Your sword is glowing with a faint blue glow."
 e1e7:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
 e1eb:  b3 ...                  PRINT_RET       "Your sword is glowing very brightly."

Routine e202, 3 locals (0000, 0000, 0000)

 e209:  41 01 06 40             JE              L00,#06 [FALSE] RFALSE
 e20d:  41 01 06 52             JE              L00,#06 [FALSE] e221
 e211:  c1 97 88 1c 0e 4c       JE              G78,#1c,#0e [FALSE] e221
 e217:  c1 95 86 93 68 9b 45    JE              G76,#93,#68,#9b [FALSE] e221
 e21e:  0d 02 01                STORE           L01,#01
 e221:  e0 1f 4a 76 93 00       CALL            94ec (#93) -> -(SP)
 e227:  a0 00 c6                JZ              (SP)+ [TRUE] e22e
 e22a:  0a 93 14 dc             TEST_ATTR       "pair of candles",#14 [TRUE] e248
 e22e:  e0 1f 4a 76 68 00       CALL            94ec (#68) -> -(SP)
 e234:  a0 00 c6                JZ              (SP)+ [TRUE] e23b
 e237:  0a 68 14 cf             TEST_ATTR       "torch",#14 [TRUE] e248
 e23b:  e0 1f 4a 76 9b 00       CALL            94ec (#9b) -> -(SP)
 e241:  a0 00 c0                JZ              (SP)+ [TRUE] RFALSE
 e244:  0a 9b 14 40             TEST_ATTR       "matchbook",#14 [FALSE] RFALSE
 e248:  a0 02 80 4a             JZ              L01 [TRUE] e294
 e24c:  b2 ...                  PRINT           "How sad for an aspiring adventurer to light a "
 e26b:  aa 86                   PRINT_OBJ       G76
 e26d:  b2 ...                  PRINT           " in a room which reeks of gas. Fortunately, there is justice in the world."
 e290:  bb                      NEW_LINE        
 e291:  8c 00 4c                JUMP            e2de
 e294:  b2 ...                  PRINT           "Oh dear. It appears that the smell coming from this room was coal gas. I would have thought twice about carrying flaming objects in here."
 e2dd:  bb                      NEW_LINE        
 e2de:  e0 0f 83 33 9e b7 00    CALL            10666 (S247) -> -(SP)
 e2e5:  b8                      RET_POPPED      

Routine e2e6, 1 local (0000)

 e2e9:  93 bd 00                GET_PARENT      "clove of garlic" -> -(SP)
 e2ec:  c1 ab 00 7f 10 00 41    JE              (SP)+,G6f,G00 [FALSE] e332
 e2f3:  b3 ...                  PRINT_RET       "In the corner of the room on the ceiling is a large vampire bat who is obviously deranged and holding his nose."
 e332:  b3 ...                  PRINT_RET       "A large vampire bat, hanging from the ceiling, swoops down at you!"

Routine e35c, 1 local (0000)

 e35f:  41 01 03 61             JE              L00,#03 [FALSE] e382
 e363:  b3 ...                  PRINT_RET       "You are in a small room which has doors only to the east and south."
 e382:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
 e386:  a0 4e 40                JZ              G3e [FALSE] RFALSE
 e389:  93 bd 00                GET_PARENT      "clove of garlic" -> -(SP)
 e38c:  c1 ab 00 7f 10 c0       JE              (SP)+,G6f,G00 [TRUE] RFALSE
 e392:  e0 3f 3f 02 00          CALL            7e04 -> -(SP)
 e397:  e0 3f 4e c9 00          CALL            9d92 -> -(SP)
 e39c:  b8                      RET_POPPED      

Routine e39e, 1 local (0000)

 e3a1:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 e3a5:  b2 ...                  PRINT           "This is a large, cold room whose sole exit is to the north. In one corner there is a machine which is reminiscent of a clothes dryer. On its face is a switch which is labelled "START". The switch does not appear to be manipulable by any human hand (unless the fingers are about 1/16 by 1/4 inch). On the front of the machine is a large lid, which is "
 e474:  0a 9e 0b 4a             TEST_ATTR       "machine",#0b [FALSE] e480
 e478:  b2 ...                  PRINT           "open."
 e47d:  8c 00 07                JUMP            e485
 e480:  b2 ...                  PRINT           "closed."
 e485:  bb                      NEW_LINE        
 e486:  b0                      RTRUE           

Routine e488, 0 locals ()

 e489:  41 88 5d 51             JE              G78,#5d [FALSE] e49c
 e48d:  b3 ...                  PRINT_RET       "It is far too large to carry."
 e49c:  41 88 2b 00 43          JE              G78,#2b [FALSE] e4e2
 e4a1:  0a 9e 0b 4c             TEST_ATTR       "machine",#0b [FALSE] e4af
 e4a5:  e0 2f 27 36 44 00       CALL            4e6c (G34) -> -(SP)
 e4ab:  ad 00                   PRINT_PADDR     (SP)+
 e4ad:  bb                      NEW_LINE        
 e4ae:  b0                      RTRUE           
 e4af:  92 9e 00 61             GET_CHILD       "machine" -> -(SP) [FALSE] e4d2
 e4b3:  b2 ...                  PRINT           "The lid opens, revealing "
 e4c4:  e0 1f 47 2c 9e 00       CALL            8e58 (#9e) -> -(SP)
 e4ca:  b2 ...                  PRINT           "."
 e4cd:  bb                      NEW_LINE        
 e4ce:  0b 9e 0b                SET_ATTR        "machine",#0b
 e4d1:  b0                      RTRUE           
 e4d2:  b2 ...                  PRINT           "The lid opens."
 e4dd:  bb                      NEW_LINE        
 e4de:  0b 9e 0b                SET_ATTR        "machine",#0b
 e4e1:  b0                      RTRUE           
 e4e2:  41 88 23 60             JE              G78,#23 [FALSE] e504
 e4e6:  0a 9e 0b 52             TEST_ATTR       "machine",#0b [FALSE] e4fa
 e4ea:  b2 ...                  PRINT           "The lid closes."
 e4f5:  bb                      NEW_LINE        
 e4f6:  0c 9e 0b                CLEAR_ATTR      "machine",#0b
 e4f9:  b0                      RTRUE           
 e4fa:  e0 2f 27 36 44 00       CALL            4e6c (G34) -> -(SP)
 e500:  ad 00                   PRINT_PADDR     (SP)+
 e502:  bb                      NEW_LINE        
 e503:  b0                      RTRUE           
 e504:  41 88 0e 40             JE              G78,#0e [FALSE] RFALSE
 e508:  a0 87 5d                JZ              G77 [FALSE] e526
 e50b:  b3 ...                  PRINT_RET       "It's not clear how to turn it on with your bare hands."
 e526:  e0 16 2b be 59 70 87 00 CALL            577c (#59,#70,G77) -> -(SP)
 e52e:  b0                      RTRUE           

Routine e530, 1 local (0000)

 e533:  41 88 59 40             JE              G78,#59 [FALSE] RFALSE
 e537:  41 87 7b 00 a0          JE              G77,#7b [FALSE] e5da
 e53c:  0a 9e 0b 5d             TEST_ATTR       "machine",#0b [FALSE] e55b
 e540:  b3 ...                  PRINT_RET       "The machine doesn't seem to want to do anything."
 e55b:  b2 ...                  PRINT           "The machine comes to life (figuratively) with a dazzling display of colored lights and bizarre noises. After a few moments, the excitement abates."
 e5ba:  bb                      NEW_LINE        
 e5bb:  06 77 9e 4c             JIN             "small pile of coal","machine" [FALSE] e5c9
 e5bf:  e0 1f 3c 5d 77 00       CALL            78ba (#77) -> -(SP)
 e5c5:  0e ab 9e                INSERT_OBJ      "huge diamond","machine"
 e5c8:  b0                      RTRUE           
 e5c9:  92 9e 01 4b             GET_CHILD       "machine" -> L00 [FALSE] e5d6
 e5cd:  e0 2f 3c 5d 01 00       CALL            78ba (L00) -> -(SP)
 e5d3:  8c ff f5                JUMP            e5c9
 e5d6:  0e 92 9e                INSERT_OBJ      "small piece of vitreous slag","machine"
 e5d9:  b0                      RTRUE           
 e5da:  a0 87 55                JZ              G77 [FALSE] e5f0
 e5dd:  b3 ...                  PRINT_RET       "You can't turn it with your hands..."
 e5f0:  b2 ...                  PRINT           "It seems that a "
 e5f7:  aa 87                   PRINT_OBJ       G77
 e5f9:  b3 ...                  PRINT_RET       " won't do."

Routine e600, 0 locals ()

 e601:  e0 1f 3c 5d 92 00       CALL            78ba (#92) -> -(SP)
 e607:  b3 ...                  PRINT_RET       "The slag was rather insubstantial, and crumbles into dust at your touch."

Routine e632, 2 locals (0000, 0000)

 e637:  41 01 01 40             JE              L00,#01 [FALSE] RFALSE
 e63b:  a2 7f 02 c2             GET_CHILD       G6f -> L01 [TRUE] e63f
 e63f:  0d a2 01                STORE           G92,#01
 e642:  a0 02 45                JZ              L01 [FALSE] e648
 e645:  8c 00 19                JUMP            e65f
 e648:  e0 2f 49 16 02 00       CALL            922c (L01) -> -(SP)
 e64e:  43 00 04 48             JG              (SP)+,#04 [FALSE] e658
 e652:  0d a2 00                STORE           G92,#00
 e655:  8c 00 09                JUMP            e65f
 e658:  a1 02 02 c2             GET_SIBLING     L01 -> L01 [TRUE] e65c
 e65c:  8c ff e5                JUMP            e642
 e65f:  41 10 e4 40             JE              G00,#e4 [FALSE] RFALSE
 e663:  a0 52 c0                JZ              G42 [TRUE] RFALSE
 e666:  e0 2f 48 31 28 00       CALL            9062 (G18) -> -(SP)
 e66c:  0d 28 00                STORE           G18,#00
 e66f:  b1                      RFALSE          

Routine e670, 1 local (0000)

 e673:  41 01 01 40             JE              L00,#01 [FALSE] RFALSE
 e677:  26 d0 7f c8             JIN             "gold coffin",G6f [TRUE] e681
 e67b:  e8 7f 01                PUSH            #01
 e67e:  8c 00 05                JUMP            e684
 e681:  e8 7f 00                PUSH            #00
 e684:  2d 9b 00                STORE           G8b,(SP)+
 e687:  b1                      RFALSE          

Routine e688, 1 local (0000)

 e68b:  41 01 06 40             JE              L00,#06 [FALSE] RFALSE
 e68f:  26 9c 7f 47             JIN             "magic boat",G6f [FALSE] e698
 e693:  0d a4 00                STORE           G94,#00
 e696:  ab a4                   RET             G94
 e698:  0d a4 01                STORE           G94,#01
 e69b:  ab a4                   RET             G94

Routine e69e, 0 locals ()

 e69f:  c1 97 88 69 8c 40       JE              G78,#69,#8c [FALSE] RFALSE
 e6a5:  41 10 1d c7             JE              G00,#1d [TRUE] e6ae
 e6a9:  41 10 88 00 b4          JE              G00,#88 [FALSE] e760
 e6ae:  a0 9e 00 7e             JZ              G8e [FALSE] e72e
 e6b2:  0c 89 07                CLEAR_ATTR      "pot of gold",#07
 e6b5:  b2 ...                  PRINT           "Suddenly, the rainbow appears to become solid and, I venture, walkable (I think the giveaway was the stairs and bannister)."
 e6fe:  bb                      NEW_LINE        
 e6ff:  41 10 88 68             JE              G00,#88 [FALSE] e729
 e703:  06 89 88 64             JIN             "pot of gold","End of Rainbow" [FALSE] e729
 e707:  b2 ...                  PRINT           "A shimmering pot of gold appears at the end of the rainbow."
 e728:  bb                      NEW_LINE        
 e729:  0d 9e 01                STORE           G8e,#01
 e72c:  ab 9e                   RET             G8e
 e72e:  e0 17 81 dc 1c f6 00    CALL            103b8 (#1c,#f6) -> -(SP)
 e735:  b2 ...                  PRINT           "The rainbow seems to have become somewhat run-of-the-mill."
 e75a:  bb                      NEW_LINE        
 e75b:  0d 9e 00                STORE           G8e,#00
 e75e:  ab 9e                   RET             G8e
 e760:  41 10 1c 4d             JE              G00,#1c [FALSE] e76f
 e764:  0d 9e 00                STORE           G8e,#00
 e767:  e0 0f 83 33 9e c9 00    CALL            10666 (S248) -> -(SP)
 e76e:  b8                      RET_POPPED      
 e76f:  b3 ...                  PRINT_RET       "A dazzling display of color briefly emanates from the sceptre."

Routine e796, 1 local (0000)

 e799:  41 01 03 40             JE              L00,#03 [FALSE] RFALSE
 e79d:  b2 ...                  PRINT           "You are at the top of Aragain Falls, an enormous waterfall with a drop of about 450 feet. The only path here is on the north end."
 e7e4:  bb                      NEW_LINE        
 e7e5:  a0 9e dc                JZ              G8e [TRUE] e802
 e7e8:  b2 ...                  PRINT           "A solid rainbow spans the falls."
 e7ff:  8c 00 25                JUMP            e825
 e802:  b2 ...                  PRINT           "A beautiful rainbow can be seen over the falls and to the west."
 e825:  bb                      NEW_LINE        
 e826:  b0                      RTRUE           

Routine e828, 0 locals ()

 e829:  c1 97 88 22 26 00 50    JE              G78,#22,#26 [FALSE] e87e
 e830:  41 10 19 4d             JE              G00,#19 [FALSE] e83f
 e834:  b3 ...                  PRINT_RET       "From here?!?"
 e83f:  a0 9e ed                JZ              G8e [TRUE] e86d
 e842:  41 10 1d 49             JE              G00,#1d [FALSE] e84d
 e846:  e0 1f 49 5b 88 00       CALL            92b6 (#88) -> -(SP)
 e84c:  b8                      RET_POPPED      
 e84d:  41 10 88 49             JE              G00,#88 [FALSE] e858
 e851:  e0 1f 49 5b 1d 00       CALL            92b6 (#1d) -> -(SP)
 e857:  b8                      RET_POPPED      
 e858:  b3 ...                  PRINT_RET       "You'll have to say which way..."
 e86d:  b3 ...                  PRINT_RET       "Can you walk on water vapor?"
 e87e:  41 88 51 40             JE              G78,#51 [FALSE] RFALSE
 e882:  b3 ...                  PRINT_RET       "The Frigid River flows under the rainbow."

Routine e89c, 0 locals ()

 e89d:  c1 97 88 32 12 4c       JE              G78,#32,#12 [FALSE] e8ad
 e8a3:  41 86 62 48             JE              G76,#62 [FALSE] e8ad
 e8a7:  e0 3f 74 72 00          CALL            e8e4 -> -(SP)
 e8ac:  b8                      RET_POPPED      
 e8ad:  c1 97 88 3b 17 5d       JE              G78,#3b,#17 [FALSE] e8ce
 e8b3:  b3 ...                  PRINT_RET       "No chance. Some moron punctured it."
 e8ce:  41 88 5f 40             JE              G78,#5f [FALSE] RFALSE
 e8d2:  41 87 62 48             JE              G77,#62 [FALSE] e8dc
 e8d6:  e0 3f 74 72 00          CALL            e8e4 -> -(SP)
 e8db:  b8                      RET_POPPED      
 e8dc:  e0 2f 60 7f 87 00       CALL            c0fe (G77) -> -(SP)
 e8e2:  b8                      RET_POPPED      

Routine e8e4, 0 locals ()

 e8e5:  b2 ...                  PRINT           "Well done. The boat is repaired."
 e8fc:  bb                      NEW_LINE        
 e8fd:  93 8e 00                GET_PARENT      "punctured boat" -> -(SP)
 e900:  2e 8d 00                INSERT_OBJ      "pile of plastic",(SP)+
 e903:  e0 1f 3c 5d 8e 00       CALL            78ba (#8e) -> -(SP)
 e909:  b8                      RET_POPPED      

Routine e90a, 0 locals ()

 e90b:  41 88 12 00 7b          JE              G78,#12 [FALSE] e989
 e910:  41 87 83 40             JE              G77,#83 [FALSE] RFALSE
 e914:  41 86 05 4a             JE              G76,#05 [FALSE] e920
 e918:  e0 0f 83 33 9e f2 00    CALL            10666 (S249) -> -(SP)
 e91f:  b8                      RET_POPPED      
 e920:  41 86 9c 5d             JE              G76,#9c [FALSE] e93f
 e924:  b3 ...                  PRINT_RET       "You should get in the boat then launch it."
 e93f:  4a 86 1a 64             TEST_ATTR       G76,#1a [FALSE] e965
 e943:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 e949:  b2 ...                  PRINT           "The "
 e94c:  aa 86                   PRINT_OBJ       G76
 e94e:  b3 ...                  PRINT_RET       " floats for a moment, then sinks."
 e965:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 e96b:  b2 ...                  PRINT           "The "
 e96e:  aa 86                   PRINT_OBJ       G76
 e970:  b3 ...                  PRINT_RET       " splashes into the water and is gone forever."
 e989:  c1 97 88 22 45 40       JE              G78,#22,#45 [FALSE] RFALSE
 e98f:  b3 ...                  PRINT_RET       "A look before leaping reveals that the river is wide and dangerous, with swift currents and large, half-hidden rocks. You decide to forgo your swim."

Routine e9e2, 1 local (0000)

 e9e5:  c1 95 10 24 23 22 d5    JE              G00,#24,#23,#22 [TRUE] e9ff
 e9ec:  c1 97 10 82 1f cf       JE              G00,#82,#1f [TRUE] e9ff
 e9f2:  e0 0f 2a 43 74 f1 00    CALL            5486 (#74f1) -> -(SP)
 e9f9:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 e9fe:  b0                      RTRUE           
 e9ff:  e0 2b 4a 24 10 26 01    CALL            9448 (G00,G16) -> L00
 ea06:  a0 01 f8                JZ              L00 [TRUE] ea3f
 ea09:  b2 ...                  PRINT           "The flow of the river carries you downstream."
 ea22:  bb                      NEW_LINE        
 ea23:  bb                      NEW_LINE        
 ea24:  e0 2f 49 5b 01 00       CALL            92b6 (L00) -> -(SP)
 ea2a:  e0 2b 4a 24 10 27 00    CALL            9448 (G00,G17) -> -(SP)
 ea31:  e0 0b 2a 39 74 f1 00 00 CALL            5472 (#74f1,(SP)+) -> -(SP)
 ea39:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 ea3e:  b0                      RTRUE           
 ea3f:  e0 0f 83 33 9f 07 00    CALL            10666 (S250) -> -(SP)
 ea46:  b8                      RET_POPPED      

Routine ea48, 2 locals (0000, 0000)

 ea4d:  c1 95 01 02 06 03 c0    JE              L00,#02,#06,#03 [TRUE] RFALSE
 ea54:  41 01 01 01 85          JE              L00,#01 [FALSE] ebdc
 ea59:  41 88 89 78             JE              G78,#89 [FALSE] ea93
 ea5d:  c1 95 86 13 1e 1d c0    JE              G76,#13,#1e,#1d [TRUE] RFALSE
 ea64:  41 10 64 48             JE              G00,#64 [FALSE] ea6e
 ea68:  c1 97 86 1f 1c c0       JE              G76,#1f,#1c [TRUE] RFALSE
 ea6e:  41 10 30 46             JE              G00,#30 [FALSE] ea76
 ea72:  41 86 1c c0             JE              G76,#1c [TRUE] RFALSE
 ea76:  b3 ...                  PRINT_RET       "Read the label for the boat's instructions."
 ea93:  41 88 4a 00 75          JE              G78,#4a [FALSE] eb0b
 ea98:  c1 95 10 24 23 22 c9    JE              G00,#24,#23,#22 [TRUE] eaa6
 ea9f:  c1 95 10 82 64 30 77    JE              G00,#82,#64,#30 [FALSE] eadb
 eaa6:  b2 ...                  PRINT           "You are on the "
 eaad:  41 10 64 4c             JE              G00,#64 [FALSE] eabb
 eab1:  b2 ...                  PRINT           "reservoir"
 eab8:  8c 00 13                JUMP            eacc
 eabb:  41 10 30 4a             JE              G00,#30 [FALSE] eac7
 eabf:  b2 ...                  PRINT           "stream"
 eac4:  8c 00 07                JUMP            eacc
 eac7:  b2 ...                  PRINT           "river"
 eacc:  b3 ...                  PRINT_RET       ", or have you forgotten?"
 eadb:  e0 2f 4a 17 25 02       CALL            942e (G15) -> L01
 eae1:  41 02 01 57             JE              L01,#01 [FALSE] eafa
 eae5:  e0 2b 4a 24 10 27 00    CALL            9448 (G00,G17) -> -(SP)
 eaec:  e0 0b 2a 39 74 f1 00 00 CALL            5472 (#74f1,(SP)+) -> -(SP)
 eaf4:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 eaf9:  b0                      RTRUE           
 eafa:  41 02 02 c1             JE              L01,#02 [TRUE] RTRUE
 eafe:  b3 ...                  PRINT_RET       "You can't launch it here."
 eb0b:  41 88 31 46             JE              G78,#31 [FALSE] eb13
 eb0f:  4a 86 1d da             TEST_ATTR       G76,#1d [TRUE] eb2b
 eb13:  41 88 12 4a             JE              G78,#12 [FALSE] eb1f
 eb17:  4a 86 1d 46             TEST_ATTR       G76,#1d [FALSE] eb1f
 eb1b:  41 87 9c ce             JE              G77,#9c [TRUE] eb2b
 eb1f:  c1 97 88 2a 13 00 a9    JE              G78,#2a,#13 [FALSE] ebcd
 eb26:  4a 87 1d 00 a4          TEST_ATTR       G77,#1d [FALSE] ebcd
 eb2b:  e0 1f 3c 5d 9c 00       CALL            78ba (#9c) -> -(SP)
 eb31:  2e 8e 10                INSERT_OBJ      "punctured boat",G00
 eb34:  e0 1b 81 dc 9c 10 00    CALL            103b8 (#9c,G00) -> -(SP)
 eb3b:  6e 7f 10                INSERT_OBJ      G6f,G00
 eb3e:  b2 ...                  PRINT           "It seems that the "
 eb45:  c1 97 88 12 31 47       JE              G78,#12,#31 [FALSE] eb50
 eb4b:  aa 86                   PRINT_OBJ       G76
 eb4d:  8c 00 04                JUMP            eb52
 eb50:  aa 87                   PRINT_OBJ       G77
 eb52:  b2 ...                  PRINT           " didn't agree with the boat, as evidenced by the loud hissing noise issuing therefrom. With a pathetic sputter, the boat deflates, leaving you without."
 ebb1:  bb                      NEW_LINE        
 ebb2:  4a 10 04 41             TEST_ATTR       G00,#04 [FALSE] RTRUE
 ebb6:  bb                      NEW_LINE        
 ebb7:  c1 97 10 64 30 4a       JE              G00,#64,#30 [FALSE] ebc5
 ebbd:  e0 0f 83 33 9f 2d 00    CALL            10666 (S251) -> -(SP)
 ebc4:  b0                      RTRUE           
 ebc5:  e0 0f 83 33 9f 40 00    CALL            10666 (S252) -> -(SP)
 ebcc:  b0                      RTRUE           
 ebcd:  41 88 4a 40             JE              G78,#4a [FALSE] RFALSE
 ebd1:  b3 ...                  PRINT_RET       "You're not in the boat!"
 ebdc:  41 88 19 00 7c          JE              G78,#19 [FALSE] ec5b
 ebe1:  26 d1 7f d6             JIN             "sceptre",G6f [TRUE] ebf9
 ebe5:  26 a9 7f d2             JIN             "nasty knife",G6f [TRUE] ebf9
 ebe9:  26 6e 7f ce             JIN             "sword",G6f [TRUE] ebf9
 ebed:  26 80 7f ca             JIN             "rusty knife",G6f [TRUE] ebf9
 ebf1:  26 da 7f c6             JIN             "bloody axe",G6f [TRUE] ebf9
 ebf5:  26 71 7f 40             JIN             "stiletto",G6f [FALSE] RFALSE
 ebf9:  b2 ...                  PRINT           "Oops! Something sharp seems to have slipped and punctured the boat. The boat deflates to the sounds of hissing, sputtering, and cursing."
 ec4a:  bb                      NEW_LINE        
 ec4b:  e0 1f 3c 5d 9c 00       CALL            78ba (#9c) -> -(SP)
 ec51:  2e 8e 10                INSERT_OBJ      "punctured boat",G00
 ec54:  e0 1f 4a 98 8e 00       CALL            9530 (#8e) -> -(SP)
 ec5a:  b0                      RTRUE           
 ec5b:  c1 97 88 3b 17 5b       JE              G78,#3b,#17 [FALSE] ec7a
 ec61:  b3 ...                  PRINT_RET       "Inflating it further would probably burst it."
 ec7a:  41 88 29 40             JE              G78,#29 [FALSE] RFALSE
 ec7e:  a3 7f 00                GET_PARENT      G6f -> -(SP)
 ec81:  41 00 9c 5d             JE              (SP)+,#9c [FALSE] eca0
 ec85:  b3 ...                  PRINT_RET       "You can't deflate the boat while you're in it."
 eca0:  26 9c 10 db             JIN             "magic boat",G00 [TRUE] ecbd
 eca4:  b3 ...                  PRINT_RET       "The boat must be on the ground to be deflated."
 ecbd:  b2 ...                  PRINT           "The boat deflates."
 ecca:  bb                      NEW_LINE        
 eccb:  0d a4 01                STORE           G94,#01
 ecce:  e0 1f 3c 5d 9c 00       CALL            78ba (#9c) -> -(SP)
 ecd4:  2e 8d 10                INSERT_OBJ      "pile of plastic",G00
 ecd7:  e0 1f 4a 98 8d 00       CALL            9530 (#8d) -> -(SP)
 ecdd:  b8                      RET_POPPED      

Routine ecde, 0 locals ()

 ecdf:  e0 19 2b be 17 86 06 00 CALL            577c (#17,G76,#06) -> -(SP)
 ece7:  b8                      RET_POPPED      

Routine ece8, 0 locals ()

 ece9:  c1 97 88 3b 17 40       JE              G78,#3b,#17 [FALSE] RFALSE
 ecef:  26 8d 10 db             JIN             "pile of plastic",G00 [TRUE] ed0c
 ecf3:  b3 ...                  PRINT_RET       "The boat must be on the ground to be inflated."
 ed0c:  41 87 ad 00 4b          JE              G77,#ad [FALSE] ed5a
 ed11:  b2 ...                  PRINT           "The boat inflates and appears seaworthy."
 ed28:  bb                      NEW_LINE        
 ed29:  0a 6c 03 dc             TEST_ATTR       "tan label",#03 [TRUE] ed47
 ed2d:  b2 ...                  PRINT           "A tan label is lying inside the boat."
 ed46:  bb                      NEW_LINE        
 ed47:  0d a4 00                STORE           G94,#00
 ed4a:  e0 1f 3c 5d 8d 00       CALL            78ba (#8d) -> -(SP)
 ed50:  2e 9c 10                INSERT_OBJ      "magic boat",G00
 ed53:  e0 1f 4a 98 9c 00       CALL            9530 (#9c) -> -(SP)
 ed59:  b8                      RET_POPPED      
 ed5a:  41 87 06 5d             JE              G77,#06 [FALSE] ed79
 ed5e:  b3 ...                  PRINT_RET       "You don't have enough lung power to inflate it."
 ed79:  b2 ...                  PRINT           "With a "
 ed80:  aa 87                   PRINT_OBJ       G77
 ed82:  b3 ...                  PRINT_RET       "? Surely you jest!"

Routine ed92, 1 local (0000)

 ed95:  41 01 06 40             JE              L00,#06 [FALSE] RFALSE
 ed99:  26 a2 7f 40             JIN             "red buoy",G6f [FALSE] RFALSE
 ed9d:  a0 24 c0                JZ              G14 [TRUE] RFALSE
 eda0:  b2 ...                  PRINT           "You notice something funny about the feel of the buoy."
 edbf:  bb                      NEW_LINE        
 edc0:  0d 24 00                STORE           G14,#00
 edc3:  ab 24                   RET             G14

Routine edc6, 0 locals ()

 edc7:  41 88 2c 40             JE              G78,#2c [FALSE] RFALSE
 edcb:  41 87 79 40             JE              G77,#79 [FALSE] RFALSE
 edcf:  95 23                   INC             G13
 edd1:  43 23 03 56             JG              G13,#03 [FALSE] ede9
 edd5:  cd 4f 23 ff ff          STORE           G13,#ffff
 edda:  26 74 10 45             JIN             "beautiful jeweled scarab",G00 [FALSE] ede1
 edde:  0b 74 07                SET_ATTR        "beautiful jeweled scarab",#07
 ede1:  e0 0f 83 33 9f 71 00    CALL            10666 (S253) -> -(SP)
 ede8:  b8                      RET_POPPED      
 ede9:  41 23 03 66             JE              G13,#03 [FALSE] ee11
 eded:  0a 74 07 40             TEST_ATTR       "beautiful jeweled scarab",#07 [FALSE] RFALSE
 edf1:  b2 ...                  PRINT           "You can see a scarab here in the sand."
 ee06:  bb                      NEW_LINE        
 ee07:  e0 1f 4a 98 74 00       CALL            9530 (#74) -> -(SP)
 ee0d:  0c 74 07                CLEAR_ATTR      "beautiful jeweled scarab",#07
 ee10:  b0                      RTRUE           
 ee11:  6f 22 23 00             LOADW           G12,G13 -> -(SP)
 ee15:  ad 00                   PRINT_PADDR     (SP)+
 ee17:  bb                      NEW_LINE        
 ee18:  b0                      RTRUE           

Routine ee1a, 2 locals (0000, 0000)

 ee1f:  41 01 03 00 6a          JE              L00,#03 [FALSE] ee8c
 ee24:  b2 ...                  PRINT           "You are about 10 feet above the ground nestled among some large branches. The nearest branch above you is above your reach."
 ee67:  bb                      NEW_LINE        
 ee68:  92 4b 02 40             GET_CHILD       "Forest Path" -> L01 [FALSE] RFALSE
 ee6c:  a1 02 00 40             GET_SIBLING     L01 -> -(SP) [FALSE] RFALSE
 ee70:  b2 ...                  PRINT           "On the ground below you can see:  "
 ee83:  e0 1f 47 2c 4b 00       CALL            8e58 (#4b) -> -(SP)
 ee89:  b3 ...                  PRINT_RET       "."
 ee8c:  41 01 01 00 cd          JE              L00,#01 [FALSE] ef5c
 ee91:  41 88 1f 4d             JE              G78,#1f [FALSE] eea0
 ee95:  41 86 f1 49             JE              G76,#f1 [FALSE] eea0
 ee99:  e0 1f 4a 38 16 00       CALL            9470 (#16) -> -(SP)
 ee9f:  b8                      RET_POPPED      
 eea0:  c1 97 88 20 1e 4d       JE              G78,#20,#1e [FALSE] eeb1
 eea6:  41 86 f1 49             JE              G76,#f1 [FALSE] eeb1
 eeaa:  e0 1f 4a 38 17 00       CALL            9470 (#17) -> -(SP)
 eeb0:  b8                      RET_POPPED      
 eeb1:  41 88 31 40             JE              G78,#31 [FALSE] RFALSE
 eeb5:  e0 3f 48 eb 00          CALL            91d6 -> -(SP)
 eeba:  a0 00 c1                JZ              (SP)+ [TRUE] RTRUE
 eebd:  41 86 59 00 40          JE              G76,#59 [FALSE] ef00
 eec2:  06 57 59 7c             JIN             "jewel-encrusted egg","bird's nest" [FALSE] ef00
 eec6:  b2 ...                  PRINT           "The nest falls to the ground, and the egg spills out of it, seriously damaged."
 eef5:  bb                      NEW_LINE        
 eef6:  e0 1f 3c 5d 57 00       CALL            78ba (#57) -> -(SP)
 eefc:  0e 56 4b                INSERT_OBJ      "broken jewel-encrusted egg","Forest Path"
 eeff:  b0                      RTRUE           
 ef00:  41 86 57 71             JE              G76,#57 [FALSE] ef33
 ef04:  b2 ...                  PRINT           "The egg falls to the ground and springs open, seriously damaged."
 ef29:  0e 57 4b                INSERT_OBJ      "jewel-encrusted egg","Forest Path"
 ef2c:  e0 3f 78 8c 00          CALL            f118 -> -(SP)
 ef31:  bb                      NEW_LINE        
 ef32:  b0                      RTRUE           
 ef33:  c1 a7 86 7f f1 d9       JE              G76,G6f,#f1 [TRUE] ef50
 ef39:  4e 86 4b                INSERT_OBJ      G76,"Forest Path"
 ef3c:  b2 ...                  PRINT           "The "
 ef3f:  aa 86                   PRINT_OBJ       G76
 ef41:  b3 ...                  PRINT_RET       " falls to the ground."
 ef50:  41 88 45 40             JE              G78,#45 [FALSE] RFALSE
 ef54:  e0 0f 83 33 9f a2 00    CALL            10666 (S257) -> -(SP)
 ef5b:  b8                      RET_POPPED      
 ef5c:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
 ef60:  e0 03 2a 39 79 54 ff ff 00 
                               CALL            5472 (#7954,#ffff) -> -(SP)
 ef69:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 ef6e:  b0                      RTRUE           

Routine ef70, 0 locals ()

 ef71:  c1 97 88 2a 2b 00 f9    JE              G78,#2a,#2b [FALSE] f06f
 ef78:  41 86 57 00 f4          JE              G76,#57 [FALSE] f06f
 ef7d:  4a 86 0b 4f             TEST_ATTR       G76,#0b [FALSE] ef8e
 ef81:  b3 ...                  PRINT_RET       "The egg is already open."
 ef8e:  a0 87 5d                JZ              G77 [FALSE] efac
 ef91:  b3 ...                  PRINT_RET       "You have neither the tools nor the expertise."
 efac:  41 87 01 5f             JE              G77,#01 [FALSE] efcd
 efb0:  b3 ...                  PRINT_RET       "I doubt you could do that without damaging it."
 efcd:  4a 87 1d cb             TEST_ATTR       G77,#1d [TRUE] efda
 efd1:  4a 87 1c c7             TEST_ATTR       G77,#1c [TRUE] efda
 efd5:  41 88 2a 00 46          JE              G78,#2a [FALSE] f01e
 efda:  b2 ...                  PRINT           "The egg is now open, but the clumsiness of your attempt has seriously compromised its esthetic appeal."
 f017:  e0 3f 78 8c 00          CALL            f118 -> -(SP)
 f01c:  bb                      NEW_LINE        
 f01d:  b0                      RTRUE           
 f01e:  4a 86 02 68             TEST_ATTR       G76,#02 [FALSE] f048
 f022:  b2 ...                  PRINT           "Not to say that using the "
 f033:  aa 87                   PRINT_OBJ       G77
 f035:  b3 ...                  PRINT_RET       " isn't original too..."
 f048:  b2 ...                  PRINT           "The concept of using a "
 f057:  aa 87                   PRINT_OBJ       G77
 f059:  b2 ...                  PRINT           " is certainly original."
 f06a:  bb                      NEW_LINE        
 f06b:  4b 86 02                SET_ATTR        G76,#02
 f06e:  b0                      RTRUE           
 f06f:  c1 97 88 41 21 00 4c    JE              G78,#41,#21 [FALSE] f0c0
 f076:  b2 ...                  PRINT           "There is a noticeable crunch from beneath you, and inspection reveals that the egg is lying open, badly damaged."
 f0b9:  e0 3f 78 8c 00          CALL            f118 -> -(SP)
 f0be:  bb                      NEW_LINE        
 f0bf:  b0                      RTRUE           
 f0c0:  c1 95 88 7f 2a 2b 40    JE              G78,#7f,#2a,#2b [FALSE] RFALSE
 f0c7:  41 88 7f 45             JE              G78,#7f [FALSE] f0ce
 f0cb:  6e 86 10                INSERT_OBJ      G76,G00
 f0ce:  b2 ...                  PRINT           "Your rather indelicate handling of the egg has caused it some damage, although you have succeeded in opening it."
 f111:  e0 3f 78 8c 00          CALL            f118 -> -(SP)
 f116:  bb                      NEW_LINE        
 f117:  b0                      RTRUE           

Routine f118, 1 local (0000)

 f11b:  06 54 57 4e             JIN             "golden clockwork canary","jewel-encrusted egg" [FALSE] f12b
 f11f:  b2 ...                  PRINT           " "
 f122:  11 53 0e 00             GET_PROP        "broken clockwork canary",#0e -> -(SP)
 f126:  ad 00                   PRINT_PADDR     (SP)+
 f128:  8c 00 08                JUMP            f131
 f12b:  e0 1f 3c 5d 53 00       CALL            78ba (#53) -> -(SP)
 f131:  93 57 00                GET_PARENT      "jewel-encrusted egg" -> -(SP)
 f134:  2e 56 00                INSERT_OBJ      "broken jewel-encrusted egg",(SP)+
 f137:  e0 1f 3c 5d 57 00       CALL            78ba (#57) -> -(SP)
 f13d:  b0                      RTRUE           

Routine f13e, 0 locals ()

 f13f:  41 88 8e 40             JE              G78,#8e [FALSE] RFALSE
 f143:  41 86 54 01 2e          JE              G76,#54 [FALSE] f274
 f148:  a0 21 00 ff             JZ              G11 [FALSE] f249
 f14c:  e0 3f 79 4c 00          CALL            f298 -> -(SP)
 f151:  a0 00 80 f6             JZ              (SP)+ [TRUE] f249
 f155:  b2 ...                  PRINT           "The canary chirps, slightly off-key, an aria from a forgotten opera. From out of the greenery flies a lovely songbird. It perches on a limb just over your head and opens its beak to sing. As it does so a beautiful brass bauble drops from its mouth, bounces off the top of your head, and lands glimmering in the grass. As the canary winds down, the songbird flies away."
 f234:  bb                      NEW_LINE        
 f235:  0d 21 01                STORE           G11,#01
 f238:  41 10 58 48             JE              G00,#58 [FALSE] f242
 f23c:  e8 7f 4b                PUSH            #4b
 f23f:  8c 00 05                JUMP            f245
 f242:  e8 bf 10                PUSH            G00
 f245:  2e 55 00                INSERT_OBJ      "beautiful brass bauble",(SP)+
 f248:  b0                      RTRUE           
 f249:  b3 ...                  PRINT_RET       "The canary chirps blithely, if somewhat tinnily, for a short time."
 f274:  b3 ...                  PRINT_RET       "There is an unpleasant grinding noise from inside the canary."

Routine f298, 0 locals ()

 f299:  c1 95 10 4e 4d 4c c1    JE              G00,#4e,#4d,#4c [TRUE] RTRUE
 f2a0:  c1 97 10 4b 58 c1       JE              G00,#4b,#58 [TRUE] RTRUE
 f2a6:  b1                      RFALSE          

Routine f2a8, 0 locals ()

 f2a9:  e0 3f 79 4c 00          CALL            f298 -> -(SP)
 f2ae:  a0 00 4f                JZ              (SP)+ [FALSE] f2be
 f2b1:  e0 0f 2a 43 79 54 00    CALL            5486 (#7954) -> -(SP)
 f2b8:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
 f2bd:  b1                      RFALSE          
 f2be:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 f2c2:  23 0f 00 40             JG              #0f,(SP)+ [FALSE] RFALSE
 f2c6:  b3 ...                  PRINT_RET       "You hear in the distance the chirping of a song bird."

Routine f2e8, 1 local (0000)

 f2eb:  41 01 02 51             JE              L00,#02 [FALSE] f2fe
 f2ef:  e0 03 2a 39 79 54 ff ff 00 
                               CALL            5472 (#7954,#ffff) -> -(SP)
 f2f8:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 f2fd:  b0                      RTRUE           
 f2fe:  41 01 01 40             JE              L00,#01 [FALSE] RFALSE
 f302:  c1 97 88 1e 20 40       JE              G78,#1e,#20 [FALSE] RFALSE
 f308:  41 86 f1 40             JE              G76,#f1 [FALSE] RFALSE
 f30c:  e0 1f 4a 38 17 00       CALL            9470 (#17) -> -(SP)
 f312:  b8                      RET_POPPED      

Routine f314, 0 locals ()

 f315:  c1 95 88 20 1f 1e 40    JE              G78,#20,#1f,#1e [FALSE] RFALSE
 f31c:  b3 ...                  PRINT_RET       "The cliff is too steep for climbing."

Routine f332, 0 locals ()

 f333:  41 88 45 ca             JE              G78,#45 [TRUE] f33f
 f337:  41 88 12 65             JE              G78,#12 [FALSE] f35e
 f33b:  41 86 05 61             JE              G76,#05 [FALSE] f35e
 f33f:  b3 ...                  PRINT_RET       "That would be very unwise. Perhaps even fatal."
 f35e:  41 87 5d 40             JE              G77,#5d [FALSE] RFALSE
 f362:  c1 97 88 81 12 40       JE              G78,#81,#12 [FALSE] RFALSE
 f368:  b2 ...                  PRINT           "The "
 f36b:  aa 86                   PRINT_OBJ       G76
 f36d:  b2 ...                  PRINT           " tumbles into the river and is seen no more."
 f384:  bb                      NEW_LINE        
 f385:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 f38b:  b8                      RET_POPPED      

Routine f38c, 1 local (0000)

 f38f:  41 10 85 d8             JE              G00,#85 [TRUE] f3a9
 f393:  0d a3 00                STORE           G93,#00
 f396:  41 88 82 40             JE              G78,#82 [FALSE] RFALSE
 f39a:  b3 ...                  PRINT_RET       "You can't tie the rope to that."
 f3a9:  41 88 82 00 56          JE              G78,#82 [FALSE] f402
 f3ae:  41 87 86 40             JE              G77,#86 [FALSE] RFALSE
 f3b2:  a0 a3 d3                JZ              G93 [TRUE] f3c6
 f3b5:  b3 ...                  PRINT_RET       "The rope is already tied to it."
 f3c6:  b2 ...                  PRINT           "The rope drops over the side and comes within ten feet of the floor."
 f3ed:  bb                      NEW_LINE        
 f3ee:  0d a3 01                STORE           G93,#01
 f3f1:  0b 81 0e                SET_ATTR        "rope",#0e
 f3f4:  93 81 01                GET_PARENT      "rope" -> L00
 f3f7:  a0 01 c6                JZ              L00 [TRUE] f3fe
 f3fa:  46 01 52 c1             JIN             L00,#52 [TRUE] RTRUE
 f3fe:  2e 81 10                INSERT_OBJ      "rope",G00
 f401:  b0                      RTRUE           
 f402:  41 88 1f 50             JE              G78,#1f [FALSE] f414
 f406:  41 86 81 4c             JE              G76,#81 [FALSE] f414
 f40a:  a0 a3 c9                JZ              G93 [TRUE] f414
 f40d:  e0 1f 4a 38 16 00       CALL            9470 (#16) -> -(SP)
 f413:  b8                      RET_POPPED      
 f414:  41 88 83 00 63          JE              G78,#83 [FALSE] f47a
 f419:  21 81 87 00 5e          JE              #81,G77 [FALSE] f47a
 f41e:  4a 86 1e 00 47          TEST_ATTR       G76,#1e [FALSE] f468
 f423:  51 86 07 00             GET_PROP        G76,#07 -> -(SP)
 f427:  42 00 00 65             JL              (SP)+,#00 [FALSE] f44e
 f42b:  b2 ...                  PRINT           "Your attempt to tie up the "
 f43a:  aa 86                   PRINT_OBJ       G76
 f43c:  b2 ...                  PRINT           " awakens him."
 f447:  e0 2f 80 6c 86 00       CALL            100d8 (G76) -> -(SP)
 f44d:  b8                      RET_POPPED      
 f44e:  b2 ...                  PRINT           "The "
 f451:  aa 86                   PRINT_OBJ       G76
 f453:  b3 ...                  PRINT_RET       " struggles and you cannot tie him up."
 f468:  b2 ...                  PRINT           "Why would you tie up a "
 f475:  aa 86                   PRINT_OBJ       G76
 f477:  b3 ...                  PRINT_RET       "?"
 f47a:  41 88 86 6b             JE              G78,#86 [FALSE] f4a7
 f47e:  a0 a3 d7                JZ              G93 [TRUE] f496
 f481:  0d a3 00                STORE           G93,#00
 f484:  0c 81 0e                CLEAR_ATTR      "rope",#0e
 f487:  b3 ...                  PRINT_RET       "The rope is now untied."
 f496:  b3 ...                  PRINT_RET       "It is not tied to anything."
 f4a7:  41 88 31 67             JE              G78,#31 [FALSE] f4d0
 f4ab:  41 10 85 63             JE              G00,#85 [FALSE] f4d0
 f4af:  a0 a3 60                JZ              G93 [FALSE] f4d0
 f4b2:  0e 81 69                INSERT_OBJ      "rope","Torch Room"
 f4b5:  b3 ...                  PRINT_RET       "The rope drops gently to the floor below."
 f4d0:  41 88 5d 40             JE              G78,#5d [FALSE] RFALSE
 f4d4:  a0 a3 c0                JZ              G93 [TRUE] RFALSE
 f4d7:  b3 ...                  PRINT_RET       "The rope is tied to the railing."

Routine f4ea, 0 locals ()

 f4eb:  41 86 81 51             JE              G76,#81 [FALSE] f4fe
 f4ef:  a0 a3 ce                JZ              G93 [TRUE] f4fe
 f4f2:  41 87 86 4a             JE              G77,#86 [FALSE] f4fe
 f4f6:  e0 1b 2b be 86 86 00    CALL            577c (#86,G76) -> -(SP)
 f4fd:  b8                      RET_POPPED      
 f4fe:  b3 ...                  PRINT_RET       "It's not attached to that!"

Routine f50e, 0 locals ()

 f50f:  c1 95 88 1f 1e 22 c6    JE              G78,#1f,#1e,#22 [TRUE] f51a
 f516:  41 88 20 ca             JE              G78,#20 [TRUE] f522
 f51a:  41 88 12 6e             JE              G78,#12 [FALSE] f54a
 f51e:  41 86 05 6a             JE              G76,#05 [FALSE] f54a
 f522:  41 10 48 49             JE              G00,#48 [FALSE] f52d
 f526:  e0 1f 4a 38 1d 00       CALL            9470 (#1d) -> -(SP)
 f52c:  b0                      RTRUE           
 f52d:  b2 ...                  PRINT           "You tumble down the slide...."
 f542:  bb                      NEW_LINE        
 f543:  e0 1f 49 5b 48 00       CALL            92b6 (#48) -> -(SP)
 f549:  b8                      RET_POPPED      
 f54a:  41 88 12 40             JE              G78,#12 [FALSE] RFALSE
 f54e:  e0 2f 7a ab 86 00       CALL            f556 (G76) -> -(SP)
 f554:  b8                      RET_POPPED      

Routine f556, 1 local (0000)

 f559:  4a 01 11 6a             TEST_ATTR       L00,#11 [FALSE] f585
 f55d:  b2 ...                  PRINT           "The "
 f560:  aa 01                   PRINT_OBJ       L00
 f562:  b2 ...                  PRINT           " falls into the slide and is gone."
 f575:  bb                      NEW_LINE        
 f576:  41 01 ed 49             JE              L00,#ed [FALSE] f581
 f57a:  e0 2f 3c 5d 01 00       CALL            78ba (L00) -> -(SP)
 f580:  b8                      RET_POPPED      
 f581:  4e 01 48                INSERT_OBJ      L00,"Cellar"
 f584:  b0                      RTRUE           
 f585:  e0 2f 27 36 45 00       CALL            4e6c (G35) -> -(SP)
 f58b:  ad 00                   PRINT_PADDR     (SP)+
 f58d:  bb                      NEW_LINE        
 f58e:  b0                      RTRUE           

Routine f590, 0 locals ()

 f591:  41 88 75 40             JE              G78,#75 [FALSE] RFALSE
 f595:  26 e1 86 40             JIN             "lunch",G76 [FALSE] RFALSE
 f599:  b3 ...                  PRINT_RET       "It smells of hot peppers."

Routine f5aa, 2 locals (0000, 0000)

 f5af:  41 88 89 5d             JE              G78,#89 [FALSE] f5ce
 f5b3:  41 10 ce 40             JE              G00,#ce [FALSE] RFALSE
 f5b7:  41 86 1d 40             JE              G76,#1d [FALSE] RFALSE
 f5bb:  b3 ...                  PRINT_RET       "You cannot enter in your condition."
 f5ce:  c1 95 88 02 00 01 c0    JE              G78,#02,#00,#01 [TRUE] RFALSE
 f5d5:  c1 95 88 08 0f 0c c0    JE              G78,#08,#0f,#0c [TRUE] RFALSE
 f5dc:  c1 95 88 06 05 07 c0    JE              G78,#06,#05,#07 [TRUE] RFALSE
 f5e3:  c1 95 88 88 2a 13 c6    JE              G78,#88,#2a,#13 [TRUE] f5ee
 f5ea:  41 88 7e 5d             JE              G78,#7e [FALSE] f609
 f5ee:  b3 ...                  PRINT_RET       "All such attacks are vain in your condition."
 f609:  c1 95 88 33 23 2b d6    JE              G78,#33,#23,#2b [TRUE] f624
 f610:  c1 95 88 29 17 2f cf    JE              G78,#29,#17,#2f [TRUE] f624
 f617:  c1 95 88 82 1c 59 c8    JE              G78,#82,#1c,#59 [TRUE] f624
 f61e:  c1 97 88 6e 86 61       JE              G78,#6e,#86 [FALSE] f643
 f624:  b3 ...                  PRINT_RET       "Even such an action is beyond your capabilities."
 f643:  41 88 87 5f             JE              G78,#87 [FALSE] f664
 f647:  b3 ...                  PRINT_RET       "Might as well. You've got an eternity."
 f664:  41 88 0e 57             JE              G78,#0e [FALSE] f67d
 f668:  b3 ...                  PRINT_RET       "You need no light to guide you."
 f67d:  41 88 09 59             JE              G78,#09 [FALSE] f698
 f681:  b3 ...                  PRINT_RET       "You're dead! How can you think of your score?"
 f698:  41 88 5d 55             JE              G78,#5d [FALSE] f6af
 f69c:  b3 ...                  PRINT_RET       "Your hand passes through its object."
 f6af:  c1 95 88 04 7f 31 51    JE              G78,#04,#7f,#31 [FALSE] f6c5
 f6b6:  b3 ...                  PRINT_RET       "You have no possessions."
 f6c5:  41 88 03 4b             JE              G78,#03 [FALSE] f6d2
 f6c9:  b3 ...                  PRINT_RET       "You are dead."
 f6d2:  41 88 4f 00 61          JE              G78,#4f [FALSE] f736
 f6d7:  b2 ...                  PRINT           "The room looks strange and unearthly"
 f6ec:  a2 10 00 c8             GET_CHILD       G00 -> -(SP) [TRUE] f6f6
 f6f0:  b2 ...                  PRINT           "."
 f6f3:  8c 00 17                JUMP            f70b
 f6f6:  b2 ...                  PRINT           " and objects appear indistinct."
 f70b:  bb                      NEW_LINE        
 f70c:  4a 10 14 e6             TEST_ATTR       G00,#14 [TRUE] f734
 f710:  b2 ...                  PRINT           "Although there is no light, the room seems dimly illuminated."
 f733:  bb                      NEW_LINE        
 f734:  bb                      NEW_LINE        
 f735:  b1                      RFALSE          
 f736:  41 88 62 00 e6          JE              G78,#62 [FALSE] f81f
 f73b:  41 10 d4 00 d2          JE              G00,#d4 [FALSE] f810
 f740:  0c a4 07                CLEAR_ATTR      "brass lantern",#07
 f743:  e3 97 7f 11 00          PUT_PROP        G6f,#11,#00
 f748:  0d 89 00                STORE           G79,#00
 f74b:  0d 58 00                STORE           G48,#00
 f74e:  0d 4e 00                STORE           G3e,#00
 f751:  06 d9 66 45             JIN             "troll","The Troll Room" [FALSE] f758
 f755:  0d 9d 00                STORE           G8d,#00
 f758:  b2 ...                  PRINT           "From the distance the sound of a lone trumpet is heard. The room becomes very bright and you feel disembodied. In a moment, the brightness fades and you find yourself rising as if from a long sleep, deep in the woods. In the distance you can faintly hear a songbird and the sounds of the forest."
 f807:  bb                      NEW_LINE        
 f808:  bb                      NEW_LINE        
 f809:  e0 1f 49 5b 4e 00       CALL            92b6 (#4e) -> -(SP)
 f80f:  b8                      RET_POPPED      
 f810:  b3 ...                  PRINT_RET       "Your prayers are not heard."
 f81f:  b2 ...                  PRINT           "You can't even do that."
 f82c:  bb                      NEW_LINE        
 f82d:  0d 7c 00                STORE           G6c,#00
 f830:  9b 02                   RET             #02

Routine f832, 0 locals ()

 f833:  a0 a0 d9                JZ              G90 [TRUE] f84d
 f836:  b3 ...                  PRINT_RET       "There's not much lake left...."
 f84d:  41 88 26 4f             JE              G78,#26 [FALSE] f85e
 f851:  b3 ...                  PRINT_RET       "It's too wide to cross."
 f85e:  41 88 22 40             JE              G78,#22 [FALSE] RFALSE
 f862:  b3 ...                  PRINT_RET       "You can't swim in this lake."

Routine f872, 0 locals ()

 f873:  c1 97 88 22 7d 51       JE              G78,#22,#7d [FALSE] f888
 f879:  b3 ...                  PRINT_RET       "You can't swim in the stream."
 f888:  41 88 26 40             JE              G78,#26 [FALSE] RFALSE
 f88c:  b3 ...                  PRINT_RET       "The other side is a sheer rock cliff."

Routine f8a4, 0 locals ()

 f8a5:  41 88 45 ca             JE              G78,#45 [TRUE] f8b1
 f8a9:  41 88 12 69             JE              G78,#12 [FALSE] f8d4
 f8ad:  41 86 05 65             JE              G76,#05 [FALSE] f8d4
 f8b1:  b3 ...                  PRINT_RET       "You look before leaping, and realize that you would never survive."
 f8d4:  41 88 26 5b             JE              G78,#26 [FALSE] f8f1
 f8d8:  b3 ...                  PRINT_RET       "It's too far to jump, and there's no bridge."
 f8f1:  c1 97 88 81 12 40       JE              G78,#81,#12 [FALSE] RFALSE
 f8f7:  41 87 0d 40             JE              G77,#0d [FALSE] RFALSE
 f8fb:  b2 ...                  PRINT           "The "
 f8fe:  aa 86                   PRINT_OBJ       G76
 f900:  b2 ...                  PRINT           " drops out of sight into the chasm."
 f915:  bb                      NEW_LINE        
 f916:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
 f91c:  b8                      RET_POPPED      

Routine f91e, 0 locals ()

 f91f:  41 88 48 40             JE              G78,#48 [FALSE] RFALSE
 f923:  b3 ...                  PRINT_RET       "No."

Routine f928, 0 locals ()

 f929:  41 88 22 49             JE              G78,#22 [FALSE] f934
 f92d:  e0 1f 4a 38 15 00       CALL            9470 (#15) -> -(SP)
 f933:  b0                      RTRUE           
 f934:  b3 ...                  PRINT_RET       "The gate is protected by an invisible force. It makes your teeth ache to touch it."

Routine f968, 0 locals ()

 f969:  c1 97 88 23 2b 4d       JE              G78,#23,#2b [FALSE] f97a
 f96f:  b3 ...                  PRINT_RET       "The door won't budge."
 f97a:  41 88 22 40             JE              G78,#22 [FALSE] RFALSE
 f97e:  e0 1f 4a 38 1c 00       CALL            9470 (#1c) -> -(SP)
 f984:  b8                      RET_POPPED      

Routine f986, 0 locals ()

 f987:  41 88 2a 40             JE              G78,#2a [FALSE] RFALSE
 f98b:  b3 ...                  PRINT_RET       "Some paint chips away, revealing more paint."

Routine f9ac, 0 locals ()

 f9ad:  41 88 18 57             JE              G78,#18 [FALSE] f9c6
 f9b1:  b3 ...                  PRINT_RET       "There is too much gas to blow away."
 f9c6:  41 88 75 40             JE              G78,#75 [FALSE] RFALSE
 f9ca:  b3 ...                  PRINT_RET       "It smells like coal gas in here."

Routine f9e0, 6 locals (0000, 0000, 0000, 0000, 0000, 0000)

 f9ed:  0d 02 00                STORE           L01,#00
 f9f0:  95 02                   INC             L01
 f9f2:  61 02 01 48             JE              L01,L00 [FALSE] f9fc
 f9f6:  0d 03 01                STORE           L02,#01
 f9f9:  8c 00 40                JUMP            fa3a
 f9fc:  6f 13 02 05             LOADW           G03,L01 -> L04
 fa00:  4f 05 00 04             LOADW           L04,#00 -> L03
 fa04:  4a 04 02 c5             TEST_ATTR       L03,#02 [TRUE] fa0b
 fa08:  8c ff e7                JUMP            f9f0
 fa0b:  51 04 11 00             GET_PROP        L03,#11 -> -(SP)
 fa0f:  e0 9f 00 01 00          CALL            (SP)+ (#01) -> -(SP)
 fa14:  a0 00 c5                JZ              (SP)+ [TRUE] fa1a
 fa17:  8c ff d8                JUMP            f9f0
 fa1a:  e0 2b 7d 87 05 06 03    CALL            fb0e (L04,L05) -> L02
 fa21:  a0 03 48                JZ              L02 [FALSE] fa2a
 fa24:  0d 03 00                STORE           L02,#00
 fa27:  8c 00 12                JUMP            fa3a
 fa2a:  41 03 02 3f c3          JE              L02,#02 [FALSE] f9f0
 fa2f:  e7 7f 03 00             RANDOM          #03 -> -(SP)
 fa33:  34 01 00 06             ADD             #01,(SP)+ -> L05
 fa37:  8c ff b8                JUMP            f9f0
 fa3a:  a0 03 c1                JZ              L02 [TRUE] RTRUE
 fa3d:  a0 06 c1                JZ              L05 [TRUE] RTRUE
 fa40:  a6 06                   DEC             [L05]
 fa42:  a0 06 3f a9             JZ              L05 [FALSE] f9ed
 fa46:  b0                      RTRUE           

Routine fa48, 6 locals (0000, 0000, 0000, 0000, 0000, 0000)

 fa55:  4f 01 00 04             LOADW           L00,#00 -> L03
 fa59:  25 05 04 45             INC_CHK         L04,L03 [FALSE] fa60
 fa5d:  8c 00 1d                JUMP            fa7b
 fa60:  6f 01 05 06             LOADW           L00,L04 -> L05
 fa64:  41 06 00 47             JE              L05,#00 [FALSE] fa6d
 fa68:  aa 03                   PRINT_OBJ       L02
 fa6a:  8c ff ee                JUMP            fa59
 fa6d:  41 06 01 47             JE              L05,#01 [FALSE] fa76
 fa71:  aa 02                   PRINT_OBJ       L01
 fa73:  8c ff e5                JUMP            fa59
 fa76:  ad 06                   PRINT_PADDR     L05
 fa78:  8c ff e0                JUMP            fa59
 fa7b:  bb                      NEW_LINE        
 fa7c:  b0                      RTRUE           

Routine fa7e, 2 locals (0001, 0000)

 fa83:  15 07 02 00             SUB             #07,#02 -> -(SP)
 fa87:  77 a7 00 00             DIV             G97,(SP)+ -> -(SP)
 fa8b:  77 11 00 00             DIV             G01,(SP)+ -> -(SP)
 fa8f:  34 02 00 02             ADD             #02,(SP)+ -> L01
 fa93:  a0 01 cb                JZ              L00 [TRUE] fa9f
 fa96:  51 7f 07 00             GET_PROP        G6f,#07 -> -(SP)
 fa9a:  74 02 00 00             ADD             L01,(SP)+ -> -(SP)
 fa9e:  b8                      RET_POPPED      
 fa9f:  ab 02                   RET             L01

Routine faa2, 4 locals (0000, 0000, 0000, 0000)

 faab:  4f 01 00 02             LOADW           L00,#00 -> L01
 faaf:  51 02 07 03             GET_PROP        L01,#07 -> L02
 fab3:  42 03 00 f4             JL              L02,#00 [TRUE] fae9
 fab7:  41 02 72 4f             JE              L01,#72 [FALSE] fac8
 fabb:  a0 2e cc                JZ              G1e [TRUE] fac8
 fabe:  43 03 02 45             JG              L02,#02 [FALSE] fac5
 fac2:  0d 03 02                STORE           L02,#02
 fac5:  0d 2e 00                STORE           G1e,#00
 fac8:  a0 87 e0                JZ              G77 [TRUE] fae9
 facb:  4a 87 1d 5c             TEST_ATTR       G77,#1d [FALSE] fae9
 facf:  4f 01 01 00             LOADW           L00,#01 -> -(SP)
 fad3:  61 00 87 54             JE              (SP)+,G77 [FALSE] fae9
 fad7:  4f 01 02 00             LOADW           L00,#02 -> -(SP)
 fadb:  75 03 00 04             SUB             L02,(SP)+ -> L03
 fadf:  42 04 01 45             JL              L03,#01 [FALSE] fae6
 fae3:  0d 04 01                STORE           L03,#01
 fae6:  2d 03 04                STORE           L02,L03
 fae9:  ab 03                   RET             L02

Routine faec, 2 locals (0000, 0000)

 faf1:  a2 01 02 c2             GET_CHILD       L00 -> L01 [TRUE] faf5
 faf5:  a0 02 c0                JZ              L01 [TRUE] RFALSE
 faf8:  c1 95 02 71 da 6e c8    JE              L01,#71,#da,#6e [TRUE] fb05
 faff:  c1 97 02 a9 80 44       JE              L01,#a9,#80 [FALSE] fb07
 fb05:  ab 02                   RET             L01
 fb07:  a1 02 02 bf ee          GET_SIBLING     L01 -> L01 [TRUE] faf8
 fb0c:  b1                      RFALSE          

Routine fb0e, 12 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000)

 fb27:  4f 01 00 03             LOADW           L00,#00 -> L02
 fb2b:  4f 01 04 04             LOADW           L00,#04 -> L03
 fb2f:  4c 7f 01                CLEAR_ATTR      G6f,#01
 fb32:  4a 03 01 5d             TEST_ATTR       L02,#01 [FALSE] fb51
 fb36:  b2 ...                  PRINT           "The "
 fb39:  aa 03                   PRINT_OBJ       L02
 fb3b:  b2 ...                  PRINT           " slowly regains his feet."
 fb4c:  bb                      NEW_LINE        
 fb4d:  4c 03 01                CLEAR_ATTR      L02,#01
 fb50:  b0                      RTRUE           
 fb51:  e0 2f 7d 51 01 00       CALL            faa2 (L00) -> -(SP)
 fb57:  2d 06 00                STORE           L05,(SP)+
 fb5a:  0d 08 01                STORE           L07,#01
 fb5d:  e0 3f 7d 3f 07          CALL            fa7e -> L06
 fb62:  43 07 00 41             JG              L06,#00 [FALSE] RTRUE
 fb66:  e0 1f 7d 3f 00 09       CALL            fa7e (#00) -> L08
 fb6c:  e0 2f 7d 76 7f 05       CALL            faec (G6f) -> L04
 fb72:  42 07 00 48             JL              L06,#00 [FALSE] fb7c
 fb76:  0d 0b 03                STORE           L0a,#03
 fb79:  8c 00 98                JUMP            fc12
 fb7c:  41 07 01 54             JE              L06,#01 [FALSE] fb92
 fb80:  43 06 02 45             JG              L05,#02 [FALSE] fb87
 fb84:  0d 06 03                STORE           L05,#03
 fb87:  55 06 01 00             SUB             L05,#01 -> -(SP)
 fb8b:  6f 1a 00 0a             LOADW           G0a,(SP)+ -> L09
 fb8f:  8c 00 3d                JUMP            fbcd
 fb92:  41 07 02 54             JE              L06,#02 [FALSE] fba8
 fb96:  43 06 03 45             JG              L05,#03 [FALSE] fb9d
 fb9a:  0d 06 04                STORE           L05,#04
 fb9d:  55 06 01 00             SUB             L05,#01 -> -(SP)
 fba1:  6f 19 00 0a             LOADW           G09,(SP)+ -> L09
 fba5:  8c 00 27                JUMP            fbcd
 fba8:  43 07 02 63             JG              L06,#02 [FALSE] fbcd
 fbac:  75 06 07 06             SUB             L05,L06 -> L05
 fbb0:  c2 8f 06 ff ff 4a       JL              L05,#ffff [FALSE] fbbe
 fbb6:  cd 4f 06 ff fe          STORE           L05,#fffe
 fbbb:  8c 00 09                JUMP            fbc5
 fbbe:  43 06 01 45             JG              L05,#01 [FALSE] fbc5
 fbc2:  0d 06 02                STORE           L05,#02
 fbc5:  54 06 02 00             ADD             L05,#02 -> -(SP)
 fbc9:  6f 18 00 0a             LOADW           G08,(SP)+ -> L09
 fbcd:  e7 7f 09 00             RANDOM          #09 -> -(SP)
 fbd1:  55 00 01 00             SUB             (SP)+,#01 -> -(SP)
 fbd5:  6f 0a 00 0b             LOADW           L09,(SP)+ -> L0a
 fbd9:  a0 02 cf                JZ              L01 [TRUE] fbe9
 fbdc:  41 0b 06 48             JE              L0a,#06 [FALSE] fbe6
 fbe0:  0d 0b 08                STORE           L0a,#08
 fbe3:  8c 00 05                JUMP            fbe9
 fbe6:  0d 0b 09                STORE           L0a,#09
 fbe9:  41 0b 06 51             JE              L0a,#06 [FALSE] fbfc
 fbed:  a0 05 ce                JZ              L04 [TRUE] fbfc
 fbf0:  e0 1f 27 21 19 00       CALL            4e42 (#19) -> -(SP)
 fbf6:  a0 00 c5                JZ              (SP)+ [TRUE] fbfc
 fbf9:  0d 0b 07                STORE           L0a,#07
 fbfc:  55 0b 01 00             SUB             L0a,#01 -> -(SP)
 fc00:  6f 04 00 00             LOADW           L03,(SP)+ -> -(SP)
 fc04:  e0 2f 27 2e 00 00       CALL            4e5c ((SP)+) -> -(SP)
 fc0a:  e0 2a 7d 24 00 7f 05 00 CALL            fa48 ((SP)+,G6f,L04) -> -(SP)
 fc12:  41 0b 01 80 7e          JE              L0a,#01 [TRUE] fc93
 fc17:  41 0b 08 45             JE              L0a,#08 [FALSE] fc1e
 fc1b:  8c 00 77                JUMP            fc93
 fc1e:  41 0b 02 45             JE              L0a,#02 [FALSE] fc25
 fc22:  8c 00 70                JUMP            fc93
 fc25:  41 0b 03 c6             JE              L0a,#03 [TRUE] fc2d
 fc29:  41 0b 09 48             JE              L0a,#09 [FALSE] fc33
 fc2d:  0d 07 00                STORE           L06,#00
 fc30:  8c 00 62                JUMP            fc93
 fc33:  41 0b 04 57             JE              L0a,#04 [FALSE] fc4c
 fc37:  96 07                   DEC             L06
 fc39:  42 07 00 45             JL              L06,#00 [FALSE] fc40
 fc3d:  0d 07 00                STORE           L06,#00
 fc40:  43 95 32 00 50          JG              G85,#32 [FALSE] fc93
 fc45:  55 95 0a 95             SUB             G85,#0a -> G85
 fc49:  8c 00 49                JUMP            fc93
 fc4c:  41 0b 05 58             JE              L0a,#05 [FALSE] fc66
 fc50:  55 07 02 07             SUB             L06,#02 -> L06
 fc54:  42 07 00 45             JL              L06,#00 [FALSE] fc5b
 fc58:  0d 07 00                STORE           L06,#00
 fc5b:  43 95 32 76             JG              G85,#32 [FALSE] fc93
 fc5f:  55 95 14 95             SUB             G85,#14 -> G85
 fc63:  8c 00 2f                JUMP            fc93
 fc66:  41 0b 06 48             JE              L0a,#06 [FALSE] fc70
 fc6a:  4b 7f 01                SET_ATTR        G6f,#01
 fc6d:  8c 00 25                JUMP            fc93
 fc70:  41 0b 07 42             JE              L0a,#07 [FALSE] fc74
 fc74:  6e 05 10                INSERT_OBJ      L04,G00
 fc77:  e0 2f 7d 76 7f 0c       CALL            faec (G6f) -> L0b
 fc7d:  a0 0c d5                JZ              L0b [TRUE] fc93
 fc80:  b2 ...                  PRINT           "Fortunately, you still have a "
 fc8d:  aa 0c                   PRINT_OBJ       L0b
 fc8f:  b2 ...                  PRINT           "."
 fc92:  bb                      NEW_LINE        
 fc93:  e0 2a 7f 4d 07 0b 09 00 CALL            fe9a (L06,L0a,L08) -> -(SP)
 fc9b:  b8                      RET_POPPED      

Routine fc9c, 13 locals (0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000, 0000)

 fcb7:  4f 13 00 0d             LOADW           G03,#00 -> L0c
 fcbb:  95 07                   INC             L06
 fcbd:  61 07 0d 45             JE              L06,L0c [FALSE] fcc4
 fcc1:  8c 00 0f                JUMP            fcd1
 fcc4:  6f 13 07 01             LOADW           G03,L06 -> L00
 fcc8:  4f 01 00 00             LOADW           L00,#00 -> -(SP)
 fccc:  61 00 86 3f ec          JE              (SP)+,G76 [FALSE] fcbb
 fcd1:  4b 86 02                SET_ATTR        G76,#02
 fcd4:  4a 7f 01 74             TEST_ATTR       G6f,#01 [FALSE] fd0a
 fcd8:  b2 ...                  PRINT           "You are still recovering from that last blow, so your attack is ineffective."
 fd05:  bb                      NEW_LINE        
 fd06:  4c 7f 01                CLEAR_ATTR      G6f,#01
 fd09:  b0                      RTRUE           
 fd0a:  e0 3f 7d 3f 05          CALL            fa7e -> L04
 fd0f:  42 05 01 45             JL              L04,#01 [FALSE] fd16
 fd13:  0d 05 01                STORE           L04,#01
 fd16:  2d 08 05                STORE           L07,L04
 fd19:  4f 01 00 02             LOADW           L00,#00 -> L01
 fd1d:  e0 2f 7d 51 01 00       CALL            faa2 (L00) -> -(SP)
 fd23:  2d 06 00                STORE           L05,(SP)+
 fd26:  0d 09 01                STORE           L08,#01
 fd29:  a0 09 66                JZ              L08 [FALSE] fd50
 fd2c:  61 86 7f 4a             JE              G76,G6f [FALSE] fd38
 fd30:  e0 0f 83 33 9f ad 00    CALL            10666 (S258) -> -(SP)
 fd37:  b8                      RET_POPPED      
 fd38:  b2 ...                  PRINT           "Attacking the "
 fd43:  aa 02                   PRINT_OBJ       L01
 fd45:  b3 ...                  PRINT_RET       " is pointless."
 fd50:  e0 2f 7d 76 02 04       CALL            faec (L01) -> L03
 fd56:  a0 04 c6                JZ              L03 [TRUE] fd5d
 fd59:  42 06 00 7c             JL              L05,#00 [FALSE] fd97
 fd5d:  b2 ...                  PRINT           "The "
 fd60:  a0 04 4c                JZ              L03 [FALSE] fd6d
 fd63:  b2 ...                  PRINT           "unarmed"
 fd6a:  8c 00 0b                JUMP            fd76
 fd6d:  b2 ...                  PRINT           "unconscious"
 fd76:  b2 ...                  PRINT           " "
 fd79:  aa 02                   PRINT_OBJ       L01
 fd7b:  b2 ...                  PRINT           " cannot defend himself: He dies."
 fd90:  bb                      NEW_LINE        
 fd91:  0d 0b 03                STORE           L0a,#03
 fd94:  8c 00 97                JUMP            fe2c
 fd97:  41 06 01 54             JE              L05,#01 [FALSE] fdad
 fd9b:  43 05 02 45             JG              L04,#02 [FALSE] fda2
 fd9f:  0d 05 03                STORE           L04,#03
 fda2:  55 05 01 00             SUB             L04,#01 -> -(SP)
 fda6:  6f 1a 00 0a             LOADW           G0a,(SP)+ -> L09
 fdaa:  8c 00 3d                JUMP            fde8
 fdad:  41 06 02 54             JE              L05,#02 [FALSE] fdc3
 fdb1:  43 05 03 45             JG              L04,#03 [FALSE] fdb8
 fdb5:  0d 05 04                STORE           L04,#04
 fdb8:  55 05 01 00             SUB             L04,#01 -> -(SP)
 fdbc:  6f 19 00 0a             LOADW           G09,(SP)+ -> L09
 fdc0:  8c 00 27                JUMP            fde8
 fdc3:  43 06 02 63             JG              L05,#02 [FALSE] fde8
 fdc7:  75 05 06 05             SUB             L04,L05 -> L04
 fdcb:  c2 8f 05 ff ff 4a       JL              L04,#ffff [FALSE] fdd9
 fdd1:  cd 4f 05 ff fe          STORE           L04,#fffe
 fdd6:  8c 00 09                JUMP            fde0
 fdd9:  43 05 01 45             JG              L04,#01 [FALSE] fde0
 fddd:  0d 05 02                STORE           L04,#02
 fde0:  54 05 02 00             ADD             L04,#02 -> -(SP)
 fde4:  6f 18 00 0a             LOADW           G08,(SP)+ -> L09
 fde8:  e7 7f 09 00             RANDOM          #09 -> -(SP)
 fdec:  55 00 01 00             SUB             (SP)+,#01 -> -(SP)
 fdf0:  6f 0a 00 0b             LOADW           L09,(SP)+ -> L0a
 fdf4:  a0 03 cf                JZ              L02 [TRUE] fe04
 fdf7:  41 0b 06 48             JE              L0a,#06 [FALSE] fe01
 fdfb:  0d 0b 08                STORE           L0a,#08
 fdfe:  8c 00 05                JUMP            fe04
 fe01:  0d 0b 09                STORE           L0a,#09
 fe04:  41 0b 06 50             JE              L0a,#06 [FALSE] fe16
 fe08:  a0 04 cd                JZ              L03 [TRUE] fe16
 fe0b:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 fe0f:  23 19 00 45             JG              #19,(SP)+ [FALSE] fe16
 fe13:  0d 0b 07                STORE           L0a,#07
 fe16:  55 0b 01 00             SUB             L0a,#01 -> -(SP)
 fe1a:  6f 17 00 00             LOADW           G07,(SP)+ -> -(SP)
 fe1e:  e0 2f 27 2e 00 00       CALL            4e5c ((SP)+) -> -(SP)
 fe24:  e0 2a 7d 24 00 86 87 00 CALL            fa48 ((SP)+,G76,G77) -> -(SP)
 fe2c:  41 0b 01 80 61          JE              L0a,#01 [TRUE] fe90
 fe31:  41 0b 08 45             JE              L0a,#08 [FALSE] fe38
 fe35:  8c 00 5a                JUMP            fe90
 fe38:  41 0b 02 49             JE              L0a,#02 [FALSE] fe43
 fe3c:  35 00 06 06             SUB             #00,L05 -> L05
 fe40:  8c 00 4f                JUMP            fe90
 fe43:  41 0b 03 c6             JE              L0a,#03 [TRUE] fe4b
 fe47:  41 0b 09 48             JE              L0a,#09 [FALSE] fe51
 fe4b:  0d 06 00                STORE           L05,#00
 fe4e:  8c 00 41                JUMP            fe90
 fe51:  41 0b 04 4e             JE              L0a,#04 [FALSE] fe61
 fe55:  96 06                   DEC             L05
 fe57:  42 06 00 77             JL              L05,#00 [FALSE] fe90
 fe5b:  0d 06 00                STORE           L05,#00
 fe5e:  8c 00 31                JUMP            fe90
 fe61:  41 0b 05 50             JE              L0a,#05 [FALSE] fe73
 fe65:  55 06 02 06             SUB             L05,#02 -> L05
 fe69:  42 06 00 65             JL              L05,#00 [FALSE] fe90
 fe6d:  0d 06 00                STORE           L05,#00
 fe70:  8c 00 1f                JUMP            fe90
 fe73:  41 0b 06 48             JE              L0a,#06 [FALSE] fe7d
 fe77:  4b 86 01                SET_ATTR        G76,#01
 fe7a:  8c 00 15                JUMP            fe90
 fe7d:  41 0b 07 42             JE              L0a,#07 [FALSE] fe81
 fe81:  4c 04 0e                CLEAR_ATTR      L03,#0e
 fe84:  4b 04 1d                SET_ATTR        L03,#1d
 fe87:  6e 04 10                INSERT_OBJ      L03,G00
 fe8a:  e0 2f 4a 98 04 00       CALL            9530 (L03) -> -(SP)
 fe90:  e0 2a 7f 78 86 06 0b 00 CALL            fef0 (G76,L05,L0a) -> -(SP)
 fe98:  b8                      RET_POPPED      

Routine fe9a, 3 locals (0000, 0000, 0000)

 fea1:  a0 01 49                JZ              L00 [FALSE] feab
 fea4:  e8 3f d8 f0             PUSH            #d8f0
 fea8:  8c 00 06                JUMP            feaf
 feab:  75 01 03 00             SUB             L00,L02 -> -(SP)
 feaf:  e3 9b 7f 07 00          PUT_PROP        G6f,#07,(SP)+
 feb4:  75 01 03 00             SUB             L00,L02 -> -(SP)
 feb8:  42 00 00 4f             JL              (SP)+,#00 [FALSE] fec9
 febc:  e0 07 2a 39 7f ea 1e 00 CALL            5472 (#7fea,#1e) -> -(SP)
 fec4:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
 fec9:  e0 3f 7d 3f 00          CALL            fa7e -> -(SP)
 fece:  43 00 00 dd             JG              (SP)+,#00 [TRUE] feed
 fed2:  e0 1f 7d 3f 00 00       CALL            fa7e (#00) -> -(SP)
 fed8:  35 00 00 00             SUB             #00,(SP)+ -> -(SP)
 fedc:  34 01 00 00             ADD             #01,(SP)+ -> -(SP)
 fee0:  e3 9b 7f 07 00          PUT_PROP        G6f,#07,(SP)+
 fee5:  e0 0f 83 33 9f bf 00    CALL            10666 (S259) -> -(SP)
 feec:  b1                      RFALSE          
 feed:  ab 02                   RET             L01

Routine fef0, 3 locals (0000, 0000, 0000)

 fef7:  e3 9b 01 07 02          PUT_PROP        L00,#07,L01
 fefc:  a0 02 00 75             JZ              L01 [FALSE] ff73
 ff00:  4c 01 02                CLEAR_ATTR      L00,#02
 ff03:  b2 ...                  PRINT           "Almost as soon as the "
 ff12:  aa 01                   PRINT_OBJ       L00
 ff14:  b2 ...                  PRINT           " breathes his last breath, a cloud of sinister black fog envelops him, and when the fog lifts, the carcass has disappeared."
 ff61:  bb                      NEW_LINE        
 ff62:  e0 2f 3c 5d 01 00       CALL            78ba (L00) -> -(SP)
 ff68:  51 01 11 00             GET_PROP        L00,#11 -> -(SP)
 ff6c:  e0 9f 00 02 00          CALL            (SP)+ (#02) -> -(SP)
 ff71:  ab 03                   RET             L02
 ff73:  41 03 02 4d             JE              L02,#02 [FALSE] ff82
 ff77:  51 01 11 00             GET_PROP        L00,#11 -> -(SP)
 ff7b:  e0 9f 00 03 00          CALL            (SP)+ (#03) -> -(SP)
 ff80:  ab 03                   RET             L02
 ff82:  ab 03                   RET             L02

Routine ff84, 3 locals (0000, 0000, 0000)

 ff8b:  51 01 07 02             GET_PROP        L00,#07 -> L01
 ff8f:  e0 3f 7d 3f 00          CALL            fa7e -> -(SP)
 ff94:  75 02 00 03             SUB             L01,(SP)+ -> L02
 ff98:  43 03 03 4b             JG              L02,#03 [FALSE] ffa5
 ff9c:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 ffa0:  23 5a 00 c1             JG              #5a,(SP)+ [TRUE] RTRUE
 ffa4:  b1                      RFALSE          
 ffa5:  43 03 00 4b             JG              L02,#00 [FALSE] ffb2
 ffa9:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 ffad:  23 4b 00 c1             JG              #4b,(SP)+ [TRUE] RTRUE
 ffb1:  b1                      RFALSE          
 ffb2:  a0 03 4b                JZ              L02 [FALSE] ffbe
 ffb5:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 ffb9:  23 32 00 c1             JG              #32,(SP)+ [TRUE] RTRUE
 ffbd:  b1                      RFALSE          
 ffbe:  43 02 01 4b             JG              L01,#01 [FALSE] ffcb
 ffc2:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 ffc6:  23 19 00 c1             JG              #19,(SP)+ [TRUE] RTRUE
 ffca:  b1                      RFALSE          
 ffcb:  e7 7f 64 00             RANDOM          #64 -> -(SP)
 ffcf:  23 0a 00 c1             JG              #0a,(SP)+ [TRUE] RTRUE
 ffd3:  b1                      RFALSE          

Routine ffd4, 1 local (0000)

 ffd7:  51 7f 07 01             GET_PROP        G6f,#07 -> L00
 ffdb:  43 01 00 4d             JG              L00,#00 [FALSE] ffea
 ffdf:  0d 01 00                STORE           L00,#00
 ffe2:  e3 9b 7f 07 01          PUT_PROP        G6f,#07,L00
 ffe7:  8c 00 0d                JUMP            fff5
 ffea:  42 01 00 49             JL              L00,#00 [FALSE] fff5
 ffee:  95 01                   INC             L00
 fff0:  e3 9b 7f 07 01          PUT_PROP        G6f,#07,L00
 fff5:  42 01 00 58             JL              L00,#00 [FALSE] 1000f
 fff9:  62 95 96 46             JL              G85,G86 [FALSE] 10001
 fffd:  54 95 0a 95             ADD             G85,#0a -> G85
10001:  e0 07 2a 39 7f ea 1e 00 CALL            5472 (#7fea,#1e) -> -(SP)
10009:  e1 97 00 00 01          STOREW          (SP)+,#00,#01
1000e:  b0                      RTRUE           
1000f:  2d 95 96                STORE           G85,G86
10012:  e0 0f 2a 43 7f ea 00    CALL            5486 (#7fea) -> -(SP)
10019:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
1001e:  b0                      RTRUE           

Routine 10020, 6 locals (0000, 0000, 0000, 0000, 0000, 0000)

1002d:  4f 13 00 02             LOADW           G03,#00 -> L01
10031:  a0 4e 40                JZ              G3e [FALSE] RFALSE
10034:  0d 03 00                STORE           L02,#00
10037:  95 03                   INC             L02
10039:  61 03 02 45             JE              L02,L01 [FALSE] 10040
1003d:  8c 00 8f                JUMP            100cd
10040:  6f 13 03 04             LOADW           G03,L02 -> L03
10044:  4f 04 00 05             LOADW           L03,#00 -> L04
10048:  66 05 10 00 5c          JIN             L04,G00 [FALSE] 100a7
1004d:  4a 05 07 80 57          TEST_ATTR       L04,#07 [TRUE] 100a7
10052:  41 05 72 4b             JE              L04,#72 [FALSE] 1005f
10056:  a0 2e c8                JZ              G1e [TRUE] 1005f
10059:  0d 2e 00                STORE           G1e,#00
1005c:  8c ff da                JUMP            10037
1005f:  51 05 07 00             GET_PROP        L04,#07 -> -(SP)
10063:  42 00 00 6b             JL              (SP)+,#00 [FALSE] 10090
10067:  4f 04 03 06             LOADW           L03,#03 -> L05
1006b:  a0 06 d8                JZ              L05 [TRUE] 10084
1006e:  e7 7f 64 00             RANDOM          #64 -> -(SP)
10072:  63 06 00 50             JG              L05,(SP)+ [FALSE] 10084
10076:  e1 97 04 03 00          STOREW          L03,#03,#00
1007b:  e0 2f 80 6c 05 00       CALL            100d8 (L04) -> -(SP)
10081:  8c ff b5                JUMP            10037
10084:  54 06 19 00             ADD             L05,#19 -> -(SP)
10088:  e1 9b 04 03 00          STOREW          L03,#03,(SP)+
1008d:  8c ff a9                JUMP            10037
10090:  4a 05 02 cf             TEST_ATTR       L04,#02 [TRUE] 100a1
10094:  51 05 11 00             GET_PROP        L04,#11 -> -(SP)
10098:  e0 9f 00 05 00          CALL            (SP)+ (#05) -> -(SP)
1009d:  a0 00 bf 98             JZ              (SP)+ [TRUE] 10037
100a1:  0d 01 01                STORE           L00,#01
100a4:  8c ff 92                JUMP            10037
100a7:  4a 05 02 4b             TEST_ATTR       L04,#02 [FALSE] 100b4
100ab:  51 05 11 00             GET_PROP        L04,#11 -> -(SP)
100af:  e0 9f 00 01 00          CALL            (SP)+ (#01) -> -(SP)
100b4:  41 05 72 45             JE              L04,#72 [FALSE] 100bb
100b8:  0d 2e 00                STORE           G1e,#00
100bb:  4c 7f 01                CLEAR_ATTR      G6f,#01
100be:  4c 05 01                CLEAR_ATTR      L04,#01
100c1:  4c 05 02                CLEAR_ATTR      L04,#02
100c4:  e0 2f 80 6c 05 00       CALL            100d8 (L04) -> -(SP)
100ca:  8c ff 6c                JUMP            10037
100cd:  a0 01 c0                JZ              L00 [TRUE] RFALSE
100d0:  e0 2f 7c f0 02 00       CALL            f9e0 (L01) -> -(SP)
100d6:  b8                      RET_POPPED      

Routine 100d8, 2 locals (0000, 0000)

100dd:  51 01 07 02             GET_PROP        L00,#07 -> L01
100e1:  42 02 00 41             JL              L01,#00 [FALSE] RTRUE
100e5:  35 00 02 00             SUB             #00,L01 -> -(SP)
100e9:  e3 9b 01 07 00          PUT_PROP        L00,#07,(SP)+
100ee:  51 01 11 00             GET_PROP        L00,#11 -> -(SP)
100f2:  e0 9f 00 04 00          CALL            (SP)+ (#04) -> -(SP)
100f7:  b0                      RTRUE           

Routine 100f8, 6 locals (0000, 0000, 0000, 0000, 0000, 0000)

10105:  e0 0f 2a 43 80 7c 01    CALL            5486 (#807c) -> L00
1010c:  11 6e 0c 02             GET_PROP        "sword",#0c -> L01
10110:  06 6e 04 00 ac          JIN             "sword","cretin" [FALSE] 101bf
10115:  e0 2f 80 e3 10 00       CALL            101c6 (G00) -> -(SP)
1011b:  a0 00 c8                JZ              (SP)+ [TRUE] 10124
1011e:  0d 03 02                STORE           L02,#02
10121:  8c 00 34                JUMP            10156
10124:  0d 04 00                STORE           L03,#00
10127:  73 10 04 04             GET_NEXT_PROP   G00,L03 -> L03
1012b:  a0 04 45                JZ              L03 [FALSE] 10131
1012e:  8c 00 27                JUMP            10156
10131:  62 04 a8 bf f3          JL              L03,G98 [TRUE] 10127
10136:  72 10 04 05             GET_PROP_ADDR   G00,L03 -> L04
1013a:  a4 05 06                GET_PROP_LEN    L04 -> L05
1013d:  c1 95 06 01 04 05 3f e4 JE              L05,#01,#04,#05 [FALSE] 10127
10145:  50 05 00 00             LOADB           L04,#00 -> -(SP)
10149:  e0 2f 80 e3 00 00       CALL            101c6 ((SP)+) -> -(SP)
1014f:  a0 00 bf d6             JZ              (SP)+ [TRUE] 10127
10153:  0d 03 01                STORE           L02,#01
10156:  61 03 02 c0             JE              L02,L01 [TRUE] RFALSE
1015a:  41 03 02 61             JE              L02,#02 [FALSE] 1017d
1015e:  b2 ...                  PRINT           "Your sword has begun to glow very brightly."
10179:  bb                      NEW_LINE        
1017a:  8c 00 3e                JUMP            101b9
1017d:  41 03 01 61             JE              L02,#01 [FALSE] 101a0
10181:  b2 ...                  PRINT           "Your sword is glowing with a faint blue glow."
1019c:  bb                      NEW_LINE        
1019d:  8c 00 1b                JUMP            101b9
101a0:  a0 03 58                JZ              L02 [FALSE] 101b9
101a3:  b2 ...                  PRINT           "Your sword is no longer glowing."
101b8:  bb                      NEW_LINE        
101b9:  e3 5b 6e 0c 03          PUT_PROP        "sword",#0c,L02
101be:  b0                      RTRUE           
101bf:  e1 97 01 00 00          STOREW          L00,#00,#00
101c4:  b1                      RFALSE          

Routine 101c6, 2 locals (0000, 0000)

101cb:  a2 01 02 c2             GET_CHILD       L00 -> L01 [TRUE] 101cf
101cf:  a0 02 c0                JZ              L01 [TRUE] RFALSE
101d2:  4a 02 1e 46             TEST_ATTR       L01,#1e [FALSE] 101da
101d6:  4a 02 07 41             TEST_ATTR       L01,#07 [FALSE] RTRUE
101da:  a1 02 02 bf f2          GET_SIBLING     L01 -> L01 [TRUE] 101cf
101df:  b1                      RFALSE          

Routine 101e0, 5 locals (0000, 0000, 0000, 0000, 0000)

101eb:  93 72 01                GET_PARENT      "thief" -> L00
101ee:  0a 72 07 c8             TEST_ATTR       "thief",#07 [TRUE] 101f8
101f2:  e8 7f 01                PUSH            #01
101f5:  8c 00 05                JUMP            101fb
101f8:  e8 7f 00                PUSH            #00
101fb:  2d 03 00                STORE           L02,(SP)+
101fe:  a0 03 c5                JZ              L02 [TRUE] 10204
10201:  93 72 01                GET_PARENT      "thief" -> L00
10204:  41 01 be 5a             JE              L00,#be [FALSE] 10220
10208:  61 01 10 d6             JE              L00,G00 [TRUE] 10220
1020c:  a0 03 ca                JZ              L02 [TRUE] 10217
1020f:  e0 3f 69 69 00          CALL            d2d2 -> -(SP)
10214:  0d 03 00                STORE           L02,#00
10217:  e0 1f 69 77 be 00       CALL            d2ee (#be) -> -(SP)
1021d:  8c 00 56                JUMP            10274
10220:  61 01 10 5e             JE              L00,G00 [FALSE] 10240
10224:  4a 01 14 da             TEST_ATTR       L00,#14 [TRUE] 10240
10228:  26 d9 10 d6             JIN             "troll",G00 [TRUE] 10240
1022c:  e0 2f 67 47 03 00       CALL            ce8e (L02) -> -(SP)
10232:  a0 00 41                JZ              (SP)+ [FALSE] RTRUE
10235:  0a 72 07 00 3c          TEST_ATTR       "thief",#07 [FALSE] 10274
1023a:  0d 03 00                STORE           L02,#00
1023d:  8c 00 36                JUMP            10274
10240:  26 72 01 4c             JIN             "thief",L00 [FALSE] 1024e
10244:  0a 72 07 c8             TEST_ATTR       "thief",#07 [TRUE] 1024e
10248:  0b 72 07                SET_ATTR        "thief",#07
1024b:  0d 03 00                STORE           L02,#00
1024e:  4a 01 03 64             TEST_ATTR       L00,#03 [FALSE] 10274
10252:  e0 25 81 dc 01 72 4b 00 CALL            103b8 (L00,#72,#4b) -> -(SP)
1025a:  4a 01 05 4f             TEST_ATTR       L00,#05 [FALSE] 1026b
1025e:  4a 10 05 4b             TEST_ATTR       G00,#05 [FALSE] 1026b
10262:  e0 2f 69 96 01 00       CALL            d32c (L00) -> -(SP)
10268:  8c 00 08                JUMP            10271
1026b:  e0 2f 81 a6 01 00       CALL            1034c (L00) -> -(SP)
10271:  2d 05 00                STORE           L04,(SP)+
10274:  a0 04 48                JZ              L03 [FALSE] 1027d
10277:  e8 7f 01                PUSH            #01
1027a:  8c 00 05                JUMP            10280
1027d:  e8 7f 00                PUSH            #00
10280:  2d 04 00                STORE           L03,(SP)+
10283:  a0 04 f1                JZ              L03 [TRUE] 102b5
10286:  a0 03 6e                JZ              L02 [FALSE] 102b5
10289:  e0 3f 81 9e 00          CALL            1033c -> -(SP)
1028e:  a0 01 c9                JZ              L00 [TRUE] 10298
10291:  a1 01 01 45             GET_SIBLING     L00 -> L00 [FALSE] 10298
10295:  8c 00 06                JUMP            1029c
10298:  92 52 01 c2             GET_CHILD       #52 -> L00 [TRUE] 1029c
1029c:  4a 01 09 bf ef          TEST_ATTR       L00,#09 [TRUE] 1028e
102a1:  4a 01 06 3f ea          TEST_ATTR       L00,#06 [FALSE] 1028e
102a6:  2e 72 01                INSERT_OBJ      "thief",L00
102a9:  0c 72 02                CLEAR_ATTR      "thief",#02
102ac:  0b 72 07                SET_ATTR        "thief",#07
102af:  0d 2f 00                STORE           G1f,#00
102b2:  8c ff 3b                JUMP            101ee
102b5:  41 01 be ca             JE              L00,#be [TRUE] 102c1
102b9:  e0 2f 81 62 01 00       CALL            102c4 (L00) -> -(SP)
102bf:  ab 05                   RET             L04
102c1:  ab 05                   RET             L04

Routine 102c4, 4 locals (0000, 0000, 0000, 0000)

102cd:  92 72 02 c2             GET_CHILD       "thief" -> L01 [TRUE] 102d1
102d1:  a0 02 44                JZ              L01 [FALSE] 102d6
102d4:  ab 04                   RET             L03
102d6:  a1 02 03 c2             GET_SIBLING     L01 -> L02 [TRUE] 102da
102da:  c1 97 02 71 73 45       JE              L01,#71,#73 [FALSE] 102e3
102e0:  8c 00 54                JUMP            10335
102e3:  51 02 0c 00             GET_PROP        L01,#0c -> -(SP)
102e7:  a0 00 00 4c             JZ              (SP)+ [FALSE] 10335
102eb:  e0 1f 27 21 1e 00       CALL            4e42 (#1e) -> -(SP)
102f1:  a0 00 80 42             JZ              (SP)+ [TRUE] 10335
102f5:  4c 02 07                CLEAR_ATTR      L01,#07
102f8:  6e 02 01                INSERT_OBJ      L01,L00
102fb:  a0 04 79                JZ              L03 [FALSE] 10335
102fe:  61 01 10 75             JE              L00,G00 [FALSE] 10335
10302:  b2 ...                  PRINT           "The robber, rummaging through his bag, dropped a few items he found valueless."
10331:  bb                      NEW_LINE        
10332:  0d 04 01                STORE           L03,#01
10335:  2d 02 03                STORE           L01,L02
10338:  8c ff 98                JUMP            102d1

Routine 1033c, 0 locals ()

1033d:  93 72 00                GET_PARENT      "thief" -> -(SP)
10340:  26 71 00 40             JIN             "stiletto",(SP)+ [FALSE] RFALSE
10344:  0b 71 0e                SET_ATTR        "stiletto",#0e
10347:  0e 71 72                INSERT_OBJ      "stiletto","thief"
1034a:  b0                      RTRUE           

Routine 1034c, 3 locals (0000, 0000, 0000)

10353:  a2 01 02 c2             GET_CHILD       L00 -> L01 [TRUE] 10357
10357:  a0 02 c0                JZ              L01 [TRUE] RFALSE
1035a:  a1 02 03 c2             GET_SIBLING     L01 -> L02 [TRUE] 1035e
1035e:  51 02 0c 00             GET_PROP        L01,#0c -> -(SP)
10362:  a0 00 00 4e             JZ              (SP)+ [FALSE] 103b2
10366:  4a 02 11 00 49          TEST_ATTR       L01,#11 [FALSE] 103b2
1036b:  4a 02 09 80 44          TEST_ATTR       L01,#09 [TRUE] 103b2
10370:  4a 02 07 80 3f          TEST_ATTR       L01,#07 [TRUE] 103b2
10375:  41 02 71 cb             JE              L01,#71 [TRUE] 10382
10379:  e0 1f 27 21 0a 00       CALL            4e42 (#0a) -> -(SP)
1037f:  a0 00 f2                JZ              (SP)+ [TRUE] 103b2
10382:  4e 02 72                INSERT_OBJ      L01,"thief"
10385:  4b 02 03                SET_ATTR        L01,#03
10388:  4b 02 07                SET_ATTR        L01,#07
1038b:  41 02 81 45             JE              L01,#81 [FALSE] 10392
1038f:  0d a3 00                STORE           G93,#00
10392:  61 01 10 40             JE              L00,G00 [FALSE] RFALSE
10396:  b2 ...                  PRINT           "You suddenly notice that the "
103a7:  aa 02                   PRINT_OBJ       L01
103a9:  b3 ...                  PRINT_RET       " vanished."
103b2:  2d 02 03                STORE           L01,L02
103b5:  8c ff a1                JUMP            10357

Routine 103b8, 6 locals (0000, 0000, 0000, 0000, 0000, 0000)

103c5:  a2 01 05 c2             GET_CHILD       L00 -> L04 [TRUE] 103c9
103c9:  a0 05 44                JZ              L04 [FALSE] 103ce
103cc:  ab 06                   RET             L05
103ce:  a1 05 04 c2             GET_SIBLING     L04 -> L03 [TRUE] 103d2
103d2:  4a 05 07 e9             TEST_ATTR       L04,#07 [TRUE] 103fd
103d6:  4a 05 09 e5             TEST_ATTR       L04,#09 [TRUE] 103fd
103da:  51 05 0c 00             GET_PROP        L04,#0c -> -(SP)
103de:  43 00 00 5d             JG              (SP)+,#00 [FALSE] 103fd
103e2:  a0 03 ca                JZ              L02 [TRUE] 103ed
103e5:  e7 7f 64 00             RANDOM          #64 -> -(SP)
103e9:  63 03 00 52             JG              L02,(SP)+ [FALSE] 103fd
103ed:  6e 05 02                INSERT_OBJ      L04,L01
103f0:  4b 05 03                SET_ATTR        L04,#03
103f3:  61 02 02 45             JE              L01,L01 [FALSE] 103fa
103f7:  4b 05 07                SET_ATTR        L04,#07
103fa:  0d 06 01                STORE           L05,#01
103fd:  2d 05 04                STORE           L04,L03
10400:  8c ff c8                JUMP            103c9

Routine 10404, 4 locals (0000, 0000, 0000, 0000)
    Action routine for:
        "diagno"

1040d:  e0 1f 7d 3f 00 01       CALL            fa7e (#00) -> L00
10413:  51 7f 07 02             GET_PROP        G6f,#07 -> L01
10417:  74 01 02 03             ADD             L00,L01 -> L02
1041b:  e0 0f 2a 43 7f ea 00    CALL            5486 (#7fea) -> -(SP)
10422:  4f 00 00 00             LOADW           (SP)+,#00 -> -(SP)
10426:  a0 00 48                JZ              (SP)+ [FALSE] 1042f
10429:  0d 02 00                STORE           L01,#00
1042c:  8c 00 06                JUMP            10433
1042f:  35 00 02 02             SUB             #00,L01 -> L01
10433:  a0 02 56                JZ              L01 [FALSE] 1044a
10436:  b2 ...                  PRINT           "You are in perfect health."
10447:  8c 00 52                JUMP            1049a
1044a:  b2 ...                  PRINT           "You have "
1044f:  41 02 01 50             JE              L01,#01 [FALSE] 10461
10453:  b2 ...                  PRINT           "a light wound,"
1045e:  8c 00 3b                JUMP            1049a
10461:  41 02 02 52             JE              L01,#02 [FALSE] 10475
10465:  b2 ...                  PRINT           "a serious wound,"
10472:  8c 00 27                JUMP            1049a
10475:  41 02 03 52             JE              L01,#03 [FALSE] 10489
10479:  b2 ...                  PRINT           "several wounds,"
10486:  8c 00 13                JUMP            1049a
10489:  43 02 03 4f             JG              L01,#03 [FALSE] 1049a
1048d:  b2 ...                  PRINT           "serious wounds,"
1049a:  a0 02 f4                JZ              L01 [TRUE] 104cf
1049d:  b2 ...                  PRINT           " which will be cured after "
104ae:  55 02 01 00             SUB             L01,#01 -> -(SP)
104b2:  36 1e 00 04             MUL             #1e,(SP)+ -> L03
104b6:  e0 0f 2a 43 7f ea 00    CALL            5486 (#7fea) -> -(SP)
104bd:  4f 00 01 00             LOADW           (SP)+,#01 -> -(SP)
104c1:  74 04 00 00             ADD             L03,(SP)+ -> -(SP)
104c5:  e6 bf 00                PRINT_NUM       (SP)+
104c8:  b2 ...                  PRINT           " moves."
104cf:  bb                      NEW_LINE        
104d0:  b2 ...                  PRINT           "You can "
104d5:  a0 03 52                JZ              L02 [FALSE] 104e8
104d8:  b2 ...                  PRINT           "expect death soon"
104e5:  8c 00 73                JUMP            10559
104e8:  41 03 01 5c             JE              L02,#01 [FALSE] 10506
104ec:  b2 ...                  PRINT           "be killed by one more light wound"
10503:  8c 00 55                JUMP            10559
10506:  41 03 02 58             JE              L02,#02 [FALSE] 10520
1050a:  b2 ...                  PRINT           "be killed by a serious wound"
1051d:  8c 00 3b                JUMP            10559
10520:  41 03 03 58             JE              L02,#03 [FALSE] 1053a
10524:  b2 ...                  PRINT           "survive one serious wound"
10537:  8c 00 21                JUMP            10559
1053a:  43 03 03 5d             JG              L02,#03 [FALSE] 10559
1053e:  b2 ...                  PRINT           "strong enough to take several wounds."
10559:  b2 ...                  PRINT           "."
1055c:  bb                      NEW_LINE        
1055d:  a0 4d c0                JZ              G3d [TRUE] RFALSE
10560:  b2 ...                  PRINT           "You have been killed "
1056d:  41 4d 01 4a             JE              G3d,#01 [FALSE] 10579
10571:  b2 ...                  PRINT           "once"
10576:  8c 00 07                JUMP            1057e
10579:  b2 ...                  PRINT           "twice"
1057e:  b3 ...                  PRINT_RET       "."

Routine 10582, 1 local (0001)
    Action routine for:
        "score"

10585:  b2 ...                  PRINT           "Your score is "
1058e:  e6 bf 11                PRINT_NUM       G01
10591:  b2 ...                  PRINT           " (total of 350 points), in "
105a6:  e6 bf 12                PRINT_NUM       G02
105a9:  41 12 01 4c             JE              G02,#01 [FALSE] 105b7
105ad:  b2 ...                  PRINT           " move."
105b4:  8c 00 09                JUMP            105be
105b7:  b2 ...                  PRINT           " moves."
105be:  bb                      NEW_LINE        
105bf:  b2 ...                  PRINT           "This gives you the rank of "
105ce:  c1 8f 11 01 5e 54       JE              G01,#015e [FALSE] 105e6
105d4:  b2 ...                  PRINT           "Master Adventurer"
105e3:  8c 00 7b                JUMP            1065f
105e6:  c3 8f 11 01 4a 4c       JG              G01,#014a [FALSE] 105f6
105ec:  b2 ...                  PRINT           "Wizard"
105f3:  8c 00 6b                JUMP            1065f
105f6:  c3 8f 11 01 2c 4c       JG              G01,#012c [FALSE] 10606
105fc:  b2 ...                  PRINT           "Master"
10603:  8c 00 5b                JUMP            1065f
10606:  43 11 c8 4e             JG              G01,#c8 [FALSE] 10616
1060a:  b2 ...                  PRINT           "Adventurer"
10613:  8c 00 4b                JUMP            1065f
10616:  43 11 64 54             JG              G01,#64 [FALSE] 1062c
1061a:  b2 ...                  PRINT           "Junior Adventurer"
10629:  8c 00 35                JUMP            1065f
1062c:  43 11 32 54             JG              G01,#32 [FALSE] 10642
10630:  b2 ...                  PRINT           "Novice Adventurer"
1063f:  8c 00 1f                JUMP            1065f
10642:  43 11 19 54             JG              G01,#19 [FALSE] 10658
10646:  b2 ...                  PRINT           "Amateur Adventurer"
10655:  8c 00 09                JUMP            1065f
10658:  b2 ...                  PRINT           "Beginner"
1065f:  b2 ...                  PRINT           "."
10662:  bb                      NEW_LINE        
10663:  ab 11                   RET             G01

Routine 10666, 2 locals (0000, 0000)

1066b:  a0 4e 80 6d             JZ              G3e [TRUE] 106da
1066f:  b2 ...                  PRINT           "
It takes a talented person to be killed while already dead. YOU are such a talent. Unfortunately, it takes a talented person to deal with it. I am not such a talent. Sorry."
106d4:  bb                      NEW_LINE        
106d5:  e0 3f 48 6a 00          CALL            90d4 -> -(SP)
106da:  ad 01                   PRINT_PADDR     L00
106dc:  bb                      NEW_LINE        
106dd:  a0 4c 50                JZ              G3c [FALSE] 106ee
106e0:  b2 ...                  PRINT           "Bad luck, huh?"
106ed:  bb                      NEW_LINE        
106ee:  e0 0f 48 31 ff f6 00    CALL            9062 (#fff6) -> -(SP)
106f5:  b2 ...                  PRINT           " 
   ****  You have died  **** 

"
1071c:  a3 7f 00                GET_PARENT      G6f -> -(SP)
1071f:  4a 00 1b 45             TEST_ATTR       (SP)+,#1b [FALSE] 10726
10723:  6e 7f 10                INSERT_OBJ      G6f,G00
10726:  42 4d 02 80 8e          JL              G3d,#02 [TRUE] 107b7
1072b:  b2 ...                  PRINT           "You clearly are a suicidal maniac. We don't allow psychotics in the cave, since they may harm other adventurers. Your remains will be installed in the Land of the Living Dead, where your fellow adventurers may gloat over them."
107b0:  bb                      NEW_LINE        
107b1:  e0 3f 48 6a 00          CALL            90d4 -> -(SP)
107b6:  b8                      RET_POPPED      
107b7:  95 4d                   INC             G3d
107b9:  6e 7f 10                INSERT_OBJ      G6f,G00
107bc:  0a d4 03 00 c2          TEST_ATTR       "Altar",#03 [FALSE] 10881
107c1:  b2 ...                  PRINT           "As you take your last breath, you feel relieved of your burdens. The feeling passes as you find yourself before the gates of Hell, where the spirits jeer at you and deny you entry. Your senses are disturbed. The objects in the dungeon appear indistinct, bleached of color, even unreal."
10864:  bb                      NEW_LINE        
10865:  bb                      NEW_LINE        
10866:  0d 4e 01                STORE           G3e,#01
10869:  0d 9d 01                STORE           G8d,#01
1086c:  0d 89 01                STORE           G79,#01
1086f:  0d 58 01                STORE           G48,#01
10872:  e3 93 7f 11 7a d5       PUT_PROP        G6f,#11,#7ad5
10878:  e0 1f 49 5b e8 00       CALL            92b6 (#e8) -> -(SP)
1087e:  8c 00 59                JUMP            108d8
10881:  b2 ...                  PRINT           "Now, let's take a look here... Well, you probably deserve another chance. I can't quite fix you up completely, but you can't have everything."
108d0:  bb                      NEW_LINE        
108d1:  bb                      NEW_LINE        
108d2:  e0 1f 49 5b 4e 00       CALL            92b6 (#4e) -> -(SP)
108d8:  0c b7 03                CLEAR_ATTR      "trap door",#03
108db:  0d 7c 00                STORE           G6c,#00
108de:  e0 3f 84 75 00          CALL            108ea -> -(SP)
108e3:  e0 3f 84 a9 00          CALL            10952 -> -(SP)
108e8:  b8                      RET_POPPED      

Routine 108ea, 4 locals (0000, 0000, 0000, 0000)

108f3:  26 a4 7f 45             JIN             "brass lantern",G6f [FALSE] 108fa
108f7:  0e a4 c1                INSERT_OBJ      "brass lantern","Living Room"
108fa:  26 d0 7f 45             JIN             "gold coffin",G6f [FALSE] 10901
108fe:  0e d0 af                INSERT_OBJ      "gold coffin","Egyptian Room"
10901:  e3 57 6e 0c 00          PUT_PROP        "sword",#0c,#00
10906:  a2 7f 03 c2             GET_CHILD       G6f -> L02 [TRUE] 1090a
1090a:  4f 97 00 04             LOADW           G87,#00 -> L03
1090e:  2d 02 03                STORE           L01,L02
10911:  a0 02 c1                JZ              L01 [TRUE] RTRUE
10914:  a1 02 03 c2             GET_SIBLING     L01 -> L02 [TRUE] 10918
10918:  51 02 0c 00             GET_PROP        L01,#0c -> -(SP)
1091c:  43 00 00 66             JG              (SP)+,#00 [FALSE] 10944
10920:  a0 01 46                JZ              L00 [FALSE] 10927
10923:  92 52 01 c2             GET_CHILD       #52 -> L00 [TRUE] 10927
10927:  4a 01 06 54             TEST_ATTR       L00,#06 [FALSE] 1093d
1092b:  4a 01 14 d0             TEST_ATTR       L00,#14 [TRUE] 1093d
1092f:  e7 7f 64 00             RANDOM          #64 -> -(SP)
10933:  23 32 00 48             JG              #32,(SP)+ [FALSE] 1093d
10937:  6e 02 01                INSERT_OBJ      L01,L00
1093a:  8c ff d3                JUMP            1090e
1093d:  a1 01 01 c2             GET_SIBLING     L00 -> L00 [TRUE] 10941
10941:  8c ff de                JUMP            10920
10944:  e7 bf 04 00             RANDOM          L03 -> -(SP)
10948:  6f 97 00 00             LOADW           G87,(SP)+ -> -(SP)
1094c:  6e 02 00                INSERT_OBJ      L01,(SP)+
1094f:  8c ff be                JUMP            1090e

Routine 10952, 0 locals ()

10953:  e0 0f 2a 43 5c 3e 00    CALL            5486 (#5c3e) -> -(SP)
1095a:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
1095f:  e0 0f 2a 43 5c 6d 00    CALL            5486 (#5c6d) -> -(SP)
10966:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
1096b:  e0 0f 2a 43 64 9f 00    CALL            5486 (#649f) -> -(SP)
10972:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
10977:  e0 0f 2a 43 6f 55 00    CALL            5486 (#6f55) -> -(SP)
1097e:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
10983:  e0 0f 2a 43 6f 6a 00    CALL            5486 (#6f6a) -> -(SP)
1098a:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
1098f:  e0 0f 2a 43 80 7c 00    CALL            5486 (#807c) -> -(SP)
10996:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
1099b:  e0 0f 2a 43 79 54 00    CALL            5486 (#7954) -> -(SP)
109a2:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
109a7:  e0 0f 2a 43 6f 46 00    CALL            5486 (#6f46) -> -(SP)
109ae:  e1 97 00 00 00          STOREW          (SP)+,#00,#00
109b3:  0c 9b 14                CLEAR_ATTR      "matchbook",#14
109b6:  b0                      RTRUE           

Routine 109b8, 0 locals ()

109b9:  e0 13 84 e6 a5 a5 c2 00 CALL            109cc (#a5,S384) -> -(SP)
109c1:  b8                      RET_POPPED      

Routine 109c2, 0 locals ()

109c3:  e0 13 84 e6 65 a5 c4 00 CALL            109cc (#65,S385) -> -(SP)
109cb:  b8                      RET_POPPED      

Routine 109cc, 2 locals (0000, 0000)

109d1:  c1 97 88 23 2b 66       JE              G78,#23,#2b [FALSE] 109fb
109d7:  b2 ...                  PRINT           "The "
109da:  ad 02                   PRINT_PADDR     L01
109dc:  b3 ...                  PRINT_RET       " are safely inside; there's no need to do that."
109fb:  c1 97 88 38 39 54       JE              G78,#38,#39 [FALSE] 10a13
10a01:  b2 ...                  PRINT           "There are lots of "
10a0a:  ad 02                   PRINT_PADDR     L01
10a0c:  b3 ...                  PRINT_RET       " in there."
10a13:  41 88 12 40             JE              G78,#12 [FALSE] RFALSE
10a17:  61 87 01 40             JE              G77,L00 [FALSE] RFALSE
10a1b:  b2 ...                  PRINT           "Don't be silly. It wouldn't be a "
10a32:  aa 01                   PRINT_OBJ       L00
10a34:  b3 ...                  PRINT_RET       " anymore."

Routine 10a3e, 0 locals ()

10a3f:  c1 95 88 39 23 2b 4b    JE              G78,#39,#23,#2b [FALSE] 10a4f
10a46:  b3 ...                  PRINT_RET       "You can't do that."
10a4f:  41 88 38 40             JE              G78,#38 [FALSE] RFALSE
10a53:  b2 ...                  PRINT           "It looks pretty much like a "
10a66:  aa 86                   PRINT_OBJ       G76
10a68:  b3 ...                  PRINT_RET       "."

Routine 10a6c, 0 locals ()

10a6d:  41 88 33 40             JE              G78,#33 [FALSE] RFALSE
10a71:  e0 2f 3c 5d 86 00       CALL            78ba (G76) -> -(SP)
10a77:  b3 ...                  PRINT_RET       "What the heck! You won't make friends this way, but nobody around here is too friendly anyhow. Gulp!"

Routine 10ab2, 0 locals ()

10ab3:  c1 97 88 58 5d 4f       JE              G78,#58,#5d [FALSE] 10ac6
10ab9:  b3 ...                  PRINT_RET       "The chain is secure."
10ac6:  c1 97 88 54 69 5b       JE              G78,#54,#69 [FALSE] 10ae5
10acc:  b3 ...                  PRINT_RET       "Perhaps you should do that to the basket."
10ae5:  41 88 38 40             JE              G78,#38 [FALSE] RFALSE
10ae9:  b3 ...                  PRINT_RET       "The chain secures a basket within the shaft."

Routine 10b04, 1 local (0000)

10b07:  41 01 02 40             JE              L00,#02 [FALSE] RFALSE
10b0b:  26 d9 10 40             JIN             "troll",G00 [FALSE] RFALSE
10b0f:  e0 1f 4a 98 d9 00       CALL            9530 (#d9) -> -(SP)
10b15:  b8                      RET_POPPED      

[End of code at 10b16]

[Start of text at 10b16]

10b16: S001 "Lying in one corner of the room is a beautifully carved crystal skull. It appears to be grinning at you rather nastily."
10b5c: S002 "From the chain is suspended a basket."
10b74: S003 "At the end of the chain is a basket."
10b8a: S004 "A hot pepper sandwich is here."
10b9e: S005 "On the ground is a red hot bell."
10bb0: S006 "On the altar is a large black book, open to page 569."
10bd2: S007 "Commandment #12592

Oh ye who go about saying unto each:  "Hello sailor":
Dost thou know the magnitude of thy sin before the gods?
Yea, verily, thou shalt be ground between two stones.
Shall the angry gods cast thy body into the whirlpool?
Surely, thy eye shall be put out with a sharp stick!
Even unto the ends of the earth shalt thou wander and
Unto the land of the dead shalt thou be sent at last.
Surely thou shalt repent of thy cunning."
10cee: S008 "An ornamented sceptre, tapering to a sharp point, is here."
10d14: S009 "A sceptre, possibly that of ancient Egypt itself, is in the coffin. The sceptre is ornamented with colored enamel, and tapers to a sharp point."
10d6a: S010 "On the table is an elongated brown sack, smelling of hot peppers."
10d94: S011 "There is a silver chalice, intricately engraved, here."
10db4: S012 "On the shore lies Poseidon's own crystal trident."
10dd6: S013 "A bottle is sitting on the table."
10dea: S014 "The solid-gold coffin used for the burial of Ramses II is here."
10e10: S015 "There is an enormous diamond (perfectly cut) here."
10e2e: S016 "There is an exquisite jade figurine here."
10e46: S017 "On a table is a nasty-looking knife."
10e5c: S018 "The deceased adventurer's useless lantern is here."
10e7c: S019 "An old leather bag, bulging with coins, is here."
10e9a: S020 "A battery-powered brass lantern is on the trophy case."
10ebe: S021 "There is a brass lantern (battery-powered) here."
10edc: S022 "A small leaflet is on the ground."
10eee: S023 ""WELCOME TO ZORK!

ZORK is a game of adventure, danger, and low cunning. In it you will explore some of the most amazing territory ever seen by mortals. No computer should be without one!"
"
10f76: S024 "There is a matchbook whose cover says "Visit Beautiful FCD#3" here."
10fa2: S025 "
(Close cover before striking)

YOU too can make BIG MONEY in the exciting field of PAPER SHUFFLING!

Mr. Anderson of Muddle, Mass. says: "Before I took this course I was a lowly bit twiddler. Now with what I learned at GUE Tech I feel really important and can obfuscate and confuse with the best."

Dr. Blank had this to say: "Ten short days ago all I could look forward to was a dead-end job as a doctor. Now I have a promising future and make really big Zorkmids."

GUE Tech can't promise these fantastic results to everyone. But when you earn your degree from GUE Tech, your future will be brighter.
"
1113c: S026 "Fortunately, there is still one chance for you to be a vandal, for on the far wall is a painting of unparalleled beauty."
1117a: S027 "A painting by a neglected genius is here."
11194: S028 "On the two ends of the altar are burning candles."
111b2: S029 "On the ground is a pile of leaves."
111c4: S030 "There is a folded pile of plastic here which has a small valve attached."
111ea: S031 "On the ground is a large platinum bar."
111fe: S032 "At the end of the rainbow is a pot of gold."
11218: S033 "The prayer is inscribed in an ancient script, rarely used today. It seems to be a philippic against small insects, absent-mindedness, and the picking up and dropping of small objects. The final verse consigns trespassers to the land of the dead. All evidence indicates that the beliefs of the ancient Zorkers were obscure."
112d4: S034 "There is a red buoy here (probably a warning)."
112ec: S035 "A large coil of rope is lying in the corner."
11304: S036 "Beside the skeleton is a rusty knife."
1131c: S037 "The engravings translate to "This space intentionally left blank.""
11346: S038 "Above the trophy case hangs an elvish sword of great antiquity."
11370: S039 "In the trophy case is an ancient parchment which appears to be a map."
11396: S040 "The map shows a forest with three clearings. The largest clearing contains a house. Three paths leave the large clearing. One of these paths, leading southwest, is marked "To Stone Barrow"."
1140c: S041 "	  !!!! 	FROBOZZ MAGIC BOAT COMPANY  !!!!

Hello, Sailor!

Instructions for use:

   To get into a body of water, say "Launch".
   To get to shore, say "Land" or the direction in which you want to maneuver the boat.

Warranty:

  This boat is guaranteed against all defects for a period of 76 milliseconds from date of purchase or until first used, whichever comes first.

Warning:
   This boat is made of thin plastic.
   Good Luck!
"
1154a: S042 "There is a suspicious-looking individual, holding a large bag, leaning against one wall. He is armed with a deadly stiletto."
11592: S043 "Sitting on the pedestal is a flaming torch, made of ivory."
115b8: S044 "Some guidebooks entitled "Flood Control Dam #3" are on the reception desk."
115ec: S045 ""	Flood Control Dam #3

FCD#3 was constructed in year 783 of the Great Underground Empire to harness the mighty Frigid River. This work was supported by a grant of 37 million zorkmids from your omnipotent local tyrant Lord Dimwit Flathead the Excessive. This impressive structure is composed of 370,000 cubic feet of concrete, is 256 feet tall at the center, and 193 feet wide at the top. The lake created behind the dam has a volume of 1.7 billion cubic feet, an area of 12 million square feet, and a shore line of 36 thousand feet.

We will now point out some of the more interesting features of FCD#3 as we conduct you on a guided tour of the facilities:
        1) You start your tour here in the Dam Lobby. You will notice on your right that...."
117d0: S046 "A nasty-looking troll, brandishing a bloody axe, blocks all passages out of the room."
117fe: S047 "Lying half buried in the mud is an old trunk, bulging with jewels."
11826: S048 "There is an old trunk here, bulging with assorted jewels."
11846: S049 "There is an object which looks like a tube of toothpaste here."
11868: S050 "---> Frobozz Magic Gunk Company <---
	  All-Purpose Gunk"
1189e: S051 "There are old engravings on the walls here."
118b4: S052 "The engravings were incised in the living rock of the cave wall by an unknown hand. They depict, in symbolic form, the beliefs of the ancient Zorkers. Skillfully interwoven with the bas reliefs are excerpts illustrating the major religious tenets of that time. Unfortunately, a later age seems to have considered them blasphemous and just as skillfully excised them."
1198a: S053 "Loosely attached to a wall is a small piece of paper."
119a8: S054 "
Congratulations!

You are the privileged owner of ZORK I: The Great Underground Empire, a self-contained and self-maintaining universe. If used and maintained in accordance with normal operating practices for small universes, ZORK will provide many months of trouble-free operation.

"
11a64: S055 "Beside you on the branch is a small bird's nest."
11a80: S056 "In the bird's nest is a large egg encrusted with precious jewels, apparently scavenged by a childless songbird. The egg is covered with fine gold inlay, and ornamented in lapis lazuli and mother-of-pearl. Unlike most eggs, this one is hinged and closed with a delicate looking clasp. The egg appears extremely fragile."
11b38: S057 "There is a somewhat ruined egg here."
11b4c: S058 "There is a golden clockwork canary nestled in the egg. It has ruby eyes and a silver beak. Through a crystal window below its left wing you can see intricate machinery inside. It appears to have wound down."
11bc4: S059 "There is a golden clockwork canary nestled in the egg. It seems to have recently had a bad experience. The mountings for its jewel-like eyes are empty, and its silver beak is crumpled. Through a cracked crystal window below its left wing you can see the remains of intricate machinery. It is not clear what result winding it would have, as the mainspring seems sprung."
11c9c: S060 "The door is boarded and you can't remove the boards."
11cb6: S061 "You are standing in front of a massive barrow of stone. In the east face is a huge stone door which is open. You cannot see into the dark of the tomb."
11d04: S062 "You are facing the north side of a white house. There is no door here, and all the windows are boarded up. To the north a narrow path winds through the trees."
11d4e: S063 "The windows are all boarded."
11d60: S064 "You are facing the south side of a white house. There is no door here, and all the windows are boarded."
11d94: S065 "This is a forest, with trees in all directions. To the east, there appears to be sunlight."
11dc4: S066 "There is no tree here suitable for climbing."
11ddc: S067 "You would need a machete to go further west."
11df6: S068 "This is a dimly lit forest, with large trees all around."
11e14: S069 "The forest becomes impenetrable to the north."
11e30: S070 "The forest thins out, revealing impassable mountains."
11e54: S071 "The mountains are impassable."
11e66: S072 "The rank undergrowth prevents eastward movement."
11e86: S073 "Storm-tossed trees block your way."
11e9e: S074 "This is a path winding through a dimly lit forest. The path heads north-south here. One particularly large tree with some low branches stands at the edge of the path."
11ef6: S075 "You cannot climb any higher."
11f06: S076 "You are in a small clearing in a well marked forest path that extends to the east and west."
11f34: S077 "Only Santa Claus climbs down chimneys."
11f50: S078 "This is the attic. The only exit is a stairway leading down."
11f6e: S079 "The door is nailed shut."
11f7c: S080 "You try to ascend the ramp, but it is impossible, and you slide back down."
11fa6: S081 "This is a small room with passages to the east and south and a forbidding hole leading west. Bloodstains and deep scratches (perhaps made by an axe) mar the walls."
11ff8: S082 "The troll fends you off with a menacing gesture."
12012: S083 "You are on the east edge of a chasm, the bottom of which cannot be seen. A narrow passage goes north, and the path you are on continues to the east."
12054: S084 "The chasm probably leads straight to the infernal regions."
12074: S085 "This is an art gallery. Most of the paintings have been stolen by vandals with exceptional taste. The vandals left through either the north or west exits."
120c8: S086 "This appears to have been an artist's studio. The walls and floors are splattered with paints of 69 different colors. Strangely enough, nothing of value is hanging here. At the south end of the room is an open door (also covered with paint). A dark and narrow chimney leads up from a fireplace; although you might be able to get up it, it seems unlikely you could get back down."
1219a: S087 "This is part of a maze of twisty little passages, all alike."
121c0: S088 "You have come to a dead end in the maze."
121d6: S089 "This is part of a maze of twisty little passages, all alike. A skeleton, probably the remains of a luckless adventurer, lies here."
12222: S090 "The grating is closed."
1222a: S091 "The east wall is solid rock."
12238: S092 "The cyclops doesn't look like he'll let you past."
12250: S093 "This is a long passage. To the west is one entrance. On the east there is an old wooden door, with a large opening in it (about cyclops sized)."
12298: S094 "This is a large room, whose east wall is solid granite. A number of discarded bags, which crumble at your touch, are scattered about on the floor. There is an exit down a staircase."
122f6: S095 "You would drown."
122fe: S096 "The dam blocks your way."
1230c: S097 "You are standing on a path beside a gently flowing stream. The path follows the stream, which flows from west to east."
1234a: S098 "The stream emerges from a spot too small for you to enter."
12368: S099 "You are on the gently flowing stream. The upstream route is too narrow to navigate, and the downstream route is invisible due to twisting walls. There is a narrow beach to land on."
123c8: S100 "The channel is too narrow."
123d8: S101 "This is a tiny cave with entrances west and north, and a staircase leading down."
123fc: S102 "This is a tiny cave with entrances west and north, and a dark, forbidding staircase leading down."
1242c: S103 "This is a cold and damp corridor where a long east-west passageway turns into a southward path."
12464: S104 "This is a long and narrow corridor where a long north-south passageway briefly narrows even further."
1249e: S105 "This is a winding passage. It seems that there are only exits on the east and north."
124c6: S106 "This is an ancient room, long under water. There is an exit to the south and a staircase leading up."
124f2: S107 "This is a narrow east-west passageway. There is a narrow stairway leading down at the north end of the room."
12522: S108 "This is a circular stone room with passages in all directions. Several of them have unfortunately been blocked by cave-ins."
12568: S109 "This cave has exits to the west and east, and narrows to a crack toward the south. The earth is particularly damp here."
125aa: S110 "It is too narrow for most insects."
125ba: S111 "This is a high north-south passage, which forks to the northeast."
125de: S112 "A chasm runs southwest to northeast and the path follows it. You are on the south side of the chasm, where a crack opens into a passage."
12624: S113 "Are you out of your mind?"
12632: S114 "Some invisible force prevents you from passing through the gate."
12656: S115 "You have entered the Land of the Living Dead. Thousands of lost souls can be heard weeping and moaning. In the corner are stacked the remains of dozens of previous adventurers less fortunate than yourself. A passage exits to the north."
126e0: S116 "You have entered a low cave with passages leading northwest and east."
126fe: S117 "This is a room which looks like an Egyptian tomb. There is an ascending staircase to the west."
1272c: S118 "You cannot go down without fracturing many bones."
12748: S119 "You cannot reach the rope."
12754: S120 "This is the north end of a large temple. On the east wall is an ancient inscription, probably a prayer in a long-forgotten language. Below the prayer is a staircase leading down. The west wall is solid granite. The exit to the north end of the room is through huge marble pillars."
127dc: S121 "This is the south end of a large temple. In front of you is what appears to be an altar. In one corner is a small hole in the floor which leads into darkness. You probably could not get back up it."
1283e: S122 "You haven't a prayer of getting the coffin down there."
1285e: S123 "This room appears to have been the waiting room for groups touring the dam. There are open doorways here to the north and east marked "Private", and there is a path leading south over the top of the dam."
128ba: S124 "This is what appears to have been the maintenance room for Flood Control Dam #3. Apparently, this room has been ransacked recently, for most of the valuable equipment is gone. On the wall in front of you is a group of buttons colored blue, yellow, brown, and red. There are doorways to the west and south."
12964: S125 "You are at the base of Flood Control Dam #3, which looms above you and to the north. The river Frigid is flowing by here. Along the river are the White Cliffs which seem to form giant walls stretching from north to south along the shores of the river as it winds its way downstream."
129f8: S126 "You are on the Frigid River in the vicinity of the Dam. The river flows quietly here. There is a landing on the west shore."
12a34: S127 "You cannot go upstream due to strong currents."
12a4e: S128 "The White Cliffs prevent your landing here."
12a68: S129 "The river turns a corner here making it impossible to see the Dam. The White Cliffs loom on the east bank and large rocks prevent landing on the west."
12ab6: S130 "There is no safe landing spot here."
12aca: S131 "Just in time you steer away from the rocks."
12ae4: S132 "The river descends here into a valley. There is a narrow beach on the west shore below the cliffs. In the distance a faint rumbling can be heard."
12b30: S133 "You are on a narrow strip of beach which runs along the base of the White Cliffs. There is a narrow path heading south along the Cliffs and a tight passage leading west into the cliffs themselves."
12b8e: S134 "The path is too narrow."
12b9a: S135 "You are on a rocky, narrow strip of beach beside the Cliffs. A narrow path leads north along the shore."
12bce: S136 "The river is running faster here and the sound ahead appears to be that of rushing water. On the east shore is a sandy beach. A small area of beach can also be seen below the cliffs on the west shore."
12c36: S137 "You can land either to the east or the west."
12c4c: S138 "The sound of rushing water is nearly unbearable here. On the east shore is a large landing area."
12c80: S139 "You are on the east shore of the river. The water here seems somewhat treacherous. A path travels from north to south here, the south end quickly turning around a sharp corner."
12cd6: S140 "You are on a large sandy beach on the east shore of the river, which is flowing quickly by. A path runs beside the river to the south here, and a passage is partially buried in sand to the northeast."
12d36: S141 "This is a sand-filled cave whose exit is to the southwest."
12d58: S142 "It's a long way..."
12d64: S143 "You are on top of a rainbow (I bet you never thought you would walk on a rainbow), with a magnificent view of the Falls. The rainbow travels east-west here."
12dbe: S144 "You are on a small, rocky beach on the continuation of the Frigid River past the Falls. The beach is narrow due to the presence of the White Cliffs. The river canyon opens here and sunlight shines in from above. A rainbow crosses over the falls to the east and a narrow path continues to the southwest."
12e5c: S145 "You are beneath the walls of the river canyon which may be climbable here. The lesser part of the runoff of Aragain Falls flows by below. To the north is a narrow path."
12eb4: S146 "You are on a ledge about halfway up the wall of the river canyon. You can see from here that the main flow from Aragain Falls twists along a passage which it is impossible for you to enter. Below you is the canyon bottom. Above you is more cliff, which appears climbable."
12f34: S147 "You are at the top of the Great Canyon on its west wall. From here there is a marvelous view of the canyon and parts of the Frigid River upstream. Across the canyon, the walls of the White Cliffs join the mighty ramparts of the Flathead Mountains to the east. Following the Canyon upstream to the north, Aragain Falls may be seen, complete with rainbow. The mighty Frigid River flows out from a great dark cavern. To the west and south can be seen an immense forest, stretching for miles around. A path leads northwest. It is possible to climb down into the canyon from here."
13076: S148 "Nice view, lousy place to jump."
1308c: S149 "You are standing at the entrance of what might have been a coal mine. The shaft enters the west wall, and there is another exit on the south end of the room."
130da: S150 "You are in a small room. Strange squeaky sounds may be heard coming from the passage at the north end. You may also escape to the east."
13120: S151 "This is a large room, in the middle of which is a small shaft descending through the floor into darkness below. To the west and the north are exits from this room. Constructed over the top of the shaft is a metal framework to which a heavy iron chain is attached."
131a0: S152 "You wouldn't fit and would die if you could."
131b8: S153 "This is a small non-descript room. However, from the direction of a small descending staircase a foul odor can be detected. To the south is a narrow tunnel."
13206: S154 "This is a small room which smells strongly of coal gas. There is a short climb up some stairs and a narrow tunnel leading east."
13246: S155 "This is a very small room. In the corner is a rickety wooden ladder, leading downward. It might be safe to descend. There is also a staircase leading upward."
13296: S156 "This is a rather wide room. On one side is the bottom of a narrow wooden ladder. To the west and the south are passages leaving the room."
132d8: S157 "You have come to a dead end in the mine."
132ee: S158 "This is a long and narrow passage, which is cluttered with broken timbers. A wide passage comes from the east and turns at the west end of the room into a very narrow passageway. From the west comes a strong draft."
13358: S159 "You cannot fit through this passage with that load."
13368: S160 "This is a small drafty room in which is the bottom of a long shaft. To the south is a passageway and to the east a very narrow passage. In the shaft can be seen a heavy iron chain."
133c4: S161 "This is a non-descript part of a coal mine."
133e0: S162 "This is a small chamber, which appears to have been part of a coal mine. On the south wall of the chamber the letters "Granite Wall" are etched in the rock. To the east is a long passage, and there is a steep metal slide twisting downward. To the north is a small opening."
13470: S163 "F"
13472: S164 "If you insist.... Poof, you're dead!"
1348e: S165 " it at the time."
13498: S166 "Kicking the "
134a0: S167 "You should have looked before you leaped."
134b4: S168 "In the movies, your life would be passing before your eyes."
134d2: S169 "Geronimo..."
134dc: S170 "Playing in this way with the "
134ea: S171 "Pushing the "
134f2: S172 "Fiddling with the "
134fc: S173 "Very good. Now you can go to the second grade."
13518: S174 "Are you enjoying yourself?"
1352a: S175 "Wheeeeeeeeee!!!!!"
1353a: S176 "Do you expect me to applaud?"
1354c: S177 " hits you squarely in the head. Normally, this wouldn't do much damage, but by incredible mischance, you fall over backwards trying to duck, and break your neck, justice being swift and merciful in the Great Underground Empire."
135d4: S178 "Oh, no! You have walked into the slavering fangs of a lurking grue!"
135fc: S179 "Waving the "
13604: S180 "  "
13606: S181 "    "
1360a: S182 "      "
1360e: S183 "        "
13614: S184 "          "
1361c: S185 " doesn't seem to work."
13628: S186 " isn't notably helpful."
1363a: S187 " has no effect."
13644: S188 " and devoured you!"
13650: S189 "You can't swim in the dungeon."
13660: S190 "Hello."
13666: S191 "Good day."
1366e: S192 "Nice weather we've been having lately."
1368a: S193 "Goodbye."
13692: S194 "A valiant attempt."
136a0: S195 "You can't be serious."
136aa: S196 "An interesting idea..."
136bc: S197 "What a concept!"
136c8: S198 "Look around."
136d2: S199 "Too late for that."
136de: S200 "Have your eyes checked."
136ee: S201 "Well, you seem to have been brushing your teeth with some sort of glue. As a result, your mouth gets glued together (with your nose) and you die of respiratory failure."
13750: S202 "With great effort, you open the window far enough to allow entry."
1377a: S203 "The window closes (more easily than it opened)."
1379a: S204 "The door reluctantly opens to reveal a rickety staircase descending into darkness."
137c6: S205 "The door swings shut and closes."
137d8: S206 "A nasty-looking troll, brandishing a bloody axe, blocks all passages out of the room."
13806: S207 "A pathetically babbling troll is here."
1381c: S208 "An unconscious troll is sprawled on the floor. All passages out of the room are open."
13848: S209 "A nasty-looking troll, brandishing a bloody axe, blocks all passages out of the room."
13876: S210 "A troll is here."
1387e: S211 "The leaves burn, and so do you."
13892: S212 "The grating opens."
1389a: S213 "The grating opens to reveal trees above you."
138b2: S214 "As the knife approaches its victim, your mind is submerged by an overmastering will. Slowly, your hand turns, until the rusty blade is an inch from your neck. The knife seems to sing as it savagely slits your throat."
1392e: S215 "I'm afraid that the leap you attempted has done you in."
1394e: S216 "You are lifted up by the rising river! You try to swim, but the currents are too strong. You come closer, closer to the awesome structure of Flood Control Dam #3. The dam beckons to you. The roar of the water nearly deafens you, but you remain conscious as you tumble over the dam toward your certain doom among the rocks at its base."
13a0e: S217 "up to your ankles."
13a18: S218 "up to your shin."
13a22: S219 "up to your knees."
13a2c: S220 "up to your hips."
13a36: S221 "up to your waist."
13a40: S222 "up to your chest."
13a4a: S223 "up to your neck."
13a54: S224 "over your head."
13a5c: S225 "high in your lungs."
13a68: S226 "The room is full of water and cannot be entered."
13a7e: S227 "I'm afraid you have done drowned yourself."
13a9a: S228 "The rising water carries the boat over the dam, down the river, and over the falls. Tsk, tsk."
13acc: S229 "The cyclops, tired of all of your games and trickery, grabs you firmly. As he licks his chops, he says "Mmm. Just like Mom used to make 'em." It's nice to be appreciated."
13b38: S230 "The cyclops seems somewhat agitated."
13b4a: S231 "The cyclops appears to be getting more agitated."
13b60: S232 "The cyclops is moving about the room, looking for something."
13b78: S233 "The cyclops was looking for salt and pepper. No doubt they are condiments for his upcoming snack."
13baa: S234 "The cyclops is moving toward you in an unfriendly manner."
13bc8: S235 "You have two choices: 1. Leave  2. Become dinner."
13bea: S236 "There is a suspicious-looking individual, holding a bag, leaning against one wall. He is armed with a vicious-looking stiletto."
13c34: S237 "There is a suspicious-looking individual lying unconscious on the ground."
13c5e: S238 "The voice of the guardian of the dungeon booms out from the darkness, "Your disrespect costs you your life!" and places your head on a sharp pole."
13cae: S239 "A booming voice says "Wrong, cretin!" and you notice that you have turned into a pile of dust. How, I can't imagine."
13cf4: S240 "There is a worthless piece of canvas here."
13d0c: S241 "The lamp appears a bit dimmer."
13d1c: S242 "The lamp is definitely dimmer now."
13d32: S243 "The lamp is nearly out."
13d40: S244 "The candles grow shorter."
13d4c: S245 "The candles are becoming quite short."
13d60: S246 "The candles won't last long now."
13d6e: S247 "
      ** BOOOOOOOOOOOM **"
13d92: S248 "The structural integrity of the rainbow is severely compromised, leaving you hanging in mid-air, supported only by water vapor. Bye."
13de4: S249 "You splash around for a while, fighting the current, then you drown."
13e0e: S250 "Unfortunately, the magic boat doesn't provide protection from the rocks and boulders one meets at the bottom of waterfalls. Including this one."
13e5a: S251 "Another pathetic sputter, this time from you, heralds your drowning."
13e80: S252 "In other words, fighting the fierce currents of the Frigid River. You manage to hold your own for a bit, but then you are carried over a waterfall and into some nasty rocks. Ouch!"
13ee2: S253 "The hole collapses, smothering you."
13efa: S254 "You seem to be digging a hole here."
13f0e: S255 "The hole is getting deeper, but that's about it."
13f28: S256 "You are surrounded by a wall of sand on all sides."
13f44: S257 "That was just a bit too far down."
13f5a: S258 "Well, you really did it that time. Is suicide painless?"
13f7e: S259 "It appears that that last blow was too much for you. I'm afraid you are dead."
13fa8: S260 "Your "
13faa: S261 " misses the "
13fb2: S262 " by an inch."
13fba: S263 "A good slash, but it misses the "
13fcc: S264 " by a mile."
13fd4: S265 "You charge, but the "
13fde: S266 " jumps nimbly aside."
13fec: S267 "Clang! Crash! The "
13ffa: S268 " parries."
14002: S269 "A quick stroke, but the "
14010: S270 " is on guard."
14018: S271 "A good stroke, but it's too slow; the "
14030: S272 " dodges."
14036: S273 " crashes down, knocking the "
14048: S274 " into dreamland."
14052: S275 "The "
14054: S276 " is battered into unconsciousness."
1406a: S277 "A furious exchange, and the "
1407a: S278 " is knocked out!"
14086: S279 "The haft of your "
1408e: S280 " knocks out the "
14094: S281 "."
14096: S282 "It's curtains for the "
140a0: S283 " as your "
140a4: S284 " removes his head."
140b0: S285 "The fatal blow strikes the "
140c0: S286 " square in the heart:  He dies."
140d4: S287 " takes a fatal blow and slumps to the floor dead."
140f2: S288 " is struck on the arm; blood begins to trickle down."
14114: S289 " pinks the "
1411a: S290 " on the wrist, but it's not serious."
14130: S291 "Your stroke lands, but it was only the flat of the blade."
14150: S292 "The blow lands, making a shallow gash in the "
1416c: S293 "'s arm!"
14172: S294 " receives a deep gash in his side."
14188: S295 "A savage blow on the thigh! The "
1419c: S296 " is stunned but can still fight!"
141b0: S297 "Slash! Your blow lands! That one hit an artery, it could be serious!"
141dc: S298 "Slash! Your stroke connects! This could be serious!"
141fc: S299 " is staggered, and drops to his knees."
14212: S300 " is momentarily disoriented and can't fight back."
14230: S301 "The force of your blow knocks the "
1423e: S302 " back, stunned."
1424a: S303 " is confused and can't fight back."
1425e: S304 "The quickness of your thrust knocks the "
14270: S305 "'s weapon is knocked to the floor, leaving him unarmed."
14294: S306 " is disarmed by a subtle feint past his guard."
142b2: S307 "The Cyclops misses, but the backwash almost knocks you over."
142ce: S308 "The Cyclops rushes you, but runs into the wall."
142e4: S309 "The Cyclops sends you crashing to the floor, unconscious."
14302: S310 "The Cyclops breaks your neck with a massive smash."
1431c: S311 "A quick punch, but it was only a glancing blow."
1433a: S312 "A glancing blow from the Cyclops' fist."
14354: S313 "The monster smashes his huge fist into your chest, breaking several ribs."
14380: S314 "The Cyclops almost knocks the wind out of you with a quick punch."
1439e: S315 "The Cyclops lands a punch that knocks the wind out of you."
143b8: S316 "Heedless of your weapons, the Cyclops tosses you against the rock wall of the room."
143e2: S317 "The Cyclops grabs your "
143ea: S318 ", tastes it, and throws it to the ground in disgust."
14406: S319 "The monster grabs you on the wrist, squeezes, and you drop your "
14428: S320 " in pain."
1442e: S321 "The Cyclops seems unable to decide whether to broil or stew his dinner."
14454: S322 "The Cyclops, no sportsman, dispatches his unconscious victim."
1447c: S323 "The troll swings his axe, but it misses."
14490: S324 "The troll's axe barely misses your ear."
144a4: S325 "The axe sweeps past as you jump aside."
144bc: S326 "The axe crashes against the rock, throwing sparks!"
144dc: S327 "The flat of the troll's axe hits you delicately on the head, knocking you out."
14506: S328 "The troll neatly removes your head."
14518: S329 "The troll's axe stroke cleaves you from the nave to the chops."
14536: S330 "The troll's axe removes your head."
14546: S331 "The axe gets you right in the side. Ouch!"
1455e: S332 "The flat of the troll's axe skins across your forearm."
1457a: S333 "The troll's swing almost knocks you over as you barely parry in time."
1459c: S334 "The troll swings his axe, and it nicks your arm as you dodge."
145bc: S335 "The troll charges, and his axe slashes you on your "
145d4: S336 " arm."
145d8: S337 "An axe stroke makes a deep wound in your leg."
145f6: S338 "The troll's axe swings down, gashing your shoulder."
14612: S339 "The troll hits you with a glancing blow, and you are momentarily stunned."
14638: S340 "The troll swings; the blade turns on your armor but crashes broadside into your head."
14666: S341 "You stagger back under a hail of axe strokes."
14684: S342 "The troll's mighty blow drops you to your knees."
1469c: S343 "The axe hits your "
146a6: S344 " and knocks it spinning."
146b2: S345 "The troll swings, you parry, but the force of his blow knocks your "
146d0: S346 " away."
146d6: S347 "The axe knocks your "
146de: S348 " out of your hand. It falls to the floor."
146f4: S349 "The troll hesitates, fingering his axe."
1470a: S350 "The troll scratches his head ruminatively:  Might you be magically protected, he wonders?"
14740: S351 "Conquering his fears, the troll puts you to death."
1475c: S352 "The thief stabs nonchalantly with his stiletto and misses."
1477a: S353 "You dodge as the thief comes in low."
1478e: S354 "You parry a lightning thrust, and the thief salutes you with a grim nod."
147b6: S355 "The thief tries to sneak past your guard, but you twist away."
147d6: S356 "Shifting in the midst of a thrust, the thief knocks you unconscious with the haft of his stiletto."
14808: S357 "The thief knocks you out."
14812: S358 "Finishing you off, the thief inserts his blade into your heart."
14834: S359 "The thief comes in from the side, feints, and inserts the blade into your ribs."
1485c: S360 "The thief bows formally, raises his stiletto, and with a wry grin, ends the battle and your life."
14890: S361 "A quick thrust pinks your left arm, and blood starts to trickle down."
148bc: S362 "The thief draws blood, raking his stiletto across your arm."
148dc: S363 "The stiletto flashes faster than you can follow, and blood wells from your leg."
14908: S364 "The thief slowly approaches, strikes like a snake, and leaves you wounded."
14934: S365 "The thief strikes like a snake! The resulting wound is serious."
1495a: S366 "The thief stabs a deep cut in your upper arm."
14972: S367 "The stiletto touches your forehead, and the blood obscures your vision."
1499a: S368 "The thief strikes at your wrist, and suddenly your grip is slippery with blood."
149c4: S369 "The butt of his stiletto cracks you on the skull, and you stagger back."
149ea: S370 "The thief rams the haft of his blade into your stomach, leaving you out of breath."
14a14: S371 "The thief attacks, and you fall back desperately."
14a30: S372 "A long, theatrical slash. You catch it on your "
14a4c: S373 ", but the thief twists his knife, and the "
14a60: S374 " goes flying."
14a6a: S375 "The thief neatly flips your "
14a78: S376 " out of your hands, and it drops to the floor."
14a90: S377 "You parry a low thrust, and your "
14aa2: S378 " slips out of your hand."
14ab0: S379 "The thief, a man of superior breeding, pauses for a moment to consider the propriety of finishing you off."
14af0: S380 "The thief amuses himself by searching your pockets."
14b0e: S381 "The thief entertains himself by rifling your pack."
14b2a: S382 "The thief, forgetting his essentially genteel upbringing, cuts your throat."
14b58: S383 "The thief, a pragmatist, dispatches you as a threat to his livelihood."
14b84: S384 "coins"
14b88: S385 "jewels"

[End of text at 14b8c]

[End of file]
