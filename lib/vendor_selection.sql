-- owner_id,name,address1,address2,address3,city,county,state,postal_code,license_type,license_number,subordinate
SELECT '"' || owner_name || '","' || trade_name || '","' || (CASE WHEN loc_street_num = '' THEN '' ELSE (loc_street_num || ' ') END) || address || '",' || (CASE WHEN address2 = '' THEN '' ELSE ('"' || address2 || '"') END) || ',' || (CASE WHEN address3 = '' THEN '' ELSE ('"' || address3 || '"') END) || ',"' || city || '","' || county || '","' || state || '","' || zip || '","' || license_rank || '","' || license_number || '",' || (CASE WHEN subordinate IS NULL OR subordinate = '' THEN '' ELSE ('"' || subordinate || '"') END) AS csv_line FROM vendors WHERE license_status = 'Current' AND license_number IS NOT NULL AND zip IS NOT NULL AND zip != '' AND owner_name IN (
  '300 INC.',
  '7-ELEVEN BEVERAGE COMPANY INC.',
  '7-ELEVEN BEVERAGE COMPANY INC. (ET AL)',
  'ABILENE COUNTRY CLUB INC.',
  'A DONKEY AND GOAT LLC',
  'ALFREDO''S PIZZA AND PASTA',
  'AMAYA''S GRILL',
  'AMC ITD INC.',
  'ANHEUSER-BUSCH LLC',
  'ARMSTRONG VINEYARDS INC.',
  'ATHENS COUNTRY CLUB',
  'AUS-TEX CONCESSION INC.',
  'BEN E. KEITH COMPANY',
  'BEVERAGE MANAGEMENT ASSOCIATES INC.',
  'BIG ANTLERS 281 INC.',
  'BIG DIAMOND NUMBER 1 INC.',
  'BL RESTAURANT OPERATIONS LLC',
  'BORGER COUNTRY CLUB',
  'BROOKSHIRE BROTHERS BEVERAGE CORPORATION',
  'BRYANT VINEYARDS LTD.',
  'BUC-EE''S LTD.',
  'BUTT, CHARLES CLARENCE (ET AL)',
  'BUZZBALLZ LLC',
  'CABANA BEVERAGES INC.',
  'CHRISTOPHER COLUMBUS CLUB',
  'CLIFFS BEVERAGE COMPANY INC.',
  'CLUB',
  'COSTCO TEXAS BEVERAGES INC.',
  'DANCING COYOTE WINES INC.',
  'D & D PACKAGE STORE LLC',
  'DOUBLEBACK LLC',
  'DRY CREEK VINEYARD INC.',
  'EL CHICO LICENSE INC.',
  'EL DURANGO BILLAR & CLUB',
  'EL HACENDADO PRIVATE CLUB ASSOCIATION IN',
  'ELYSIAN BREWING COMPANY INC.',
  'FCF RESTAURANTS INC.',
  'FIESTA MART INC.',
  'FLOOD DISTRIBUTION LLC',
  'GABRIEL INVESTMENT GROUP INC.',
  'GATEWAY BEVERAGES INC.',
  'GLAZERS INC.',
  'GULLEY''S DIVING SERVICE INC.',
  'HALILI''S',
  'HEB BEVERAGE COMPANY LLC',
  'HEB GROCERY COMPANY LP',
  'INK LC BEVERAGE COMPANY LLC',
  'INVESTORS OF AMERICAN LP',
  'ISLAMORADA FISH COMPANY TEXAS LLC',
  'JALAPENOS PRIVATE CLUB',
  'JANGUL LLC',
  'JOEY''S INC.',
  'JOSEPH PHELPS VINEYARDS LLC',
  'KAYCEE CLUB INC.',
  'KIM''S BEVERAGE LLC',
  'KNEE DEEP BREWING COMPANY LLC',
  'LAKESIDE GRILL COMPANY',
  'LAKEWOOD BREWING COMPANY LLC',
  'LALLEY, NUIKO N',
  'L. B. D. CORPORATION',
  'LBW 3320 WHITE OAK NP',
  'L & F DISTRIBUTORS LLC',
  'LIQUOR, WINE & SUNSHINE LLC',
  'LOS SAPITOS',
  'LOWDEN SCHOOLHOUSE CORPORATION',
  'L P BEVERAGES',
  'LUIGI''S CAFE PRIVATE CLUB',
  'MAIN STREET TRADERS LLC',
  'MALAI LLC',
  'METROPLEX SPORTSERVICE INC.',
  'MILLERCOORS LLC',
  'NERI''S HOSPITALITY INC.',
  'NEXT PRODUCTIONS INC.',
  'NKE L.L.C.',
  'OASIS CLUB',
  'ONE TRUE VINE LLC',
  'O''SHAUGHNESSY DEL OSO LLC',
  'OUTBACK BEVERAGES OF TEXAS LLC',
  'OZONA COUNTRY CLUB',
  'PABST BREWING COMPANY LLC',
  'PAY AND SAVE INC.',
  'PECAN PLANTATION OWNERS ASSOCIATION INC.',
  'PINKIE''S INC.',
  'PLAYERS',
  'PRIZZM CORPORATION',
  'QUAD HOTELS LLC',
  'RACK DADDY''S',
  'RAILROAD PRIVATE CLUB',
  'RED LOBSTER OF TEXAS INC.',
  'REPUBLIC OF TEXAS SPORTS BAR AND GRILL',
  'RIVERSIDE DREAMER LLC',
  'ROANOKE RED ROOF CLUB INC.',
  'RUSH CREEK YACHT CLUB',
  'SIDE STREET BAR INC.',
  'SILVER EAGLE DISTRIBUTORS L.P.',
  'SILVER SPUR PRIVATE CLUB INC.',
  'SKYLINE COUNTRY CLUB',
  'SOUTHERN JUNCTION',
  'SPEC''S FAMILY PARTNERS LTD.',
  'S.P.I. SEASCAPE INC.',
  'STOCKTON, RUSSELL',
  'STONECUSHION INC.',
  'TEQUILAS INC.',
  'TEXAS STAR',
  'TEX MEX TOURS INC.',
  'TOP SHELF INDUSTRIES OPERATING LTD.',
  'TOP SHELF SPIRITS BEER AND WINE LLC',
  'TRIPLE CROWN LIQUOR LLC',
  'TWIN LIQUORS LP',
  'UNITED SUPERMARKETS L.L.C.',
  'UNTI WINE COMPANY LLC',
  'VAN DUZER VINEYARDS LLC',
  'VERMONT HARD CIDER COMPANY LLC',
  'VIGNETTE WINERY LLC',
  'VINE CLIFF WINERY INC.',
  'WE HEART BEER LLC',
  'WHITE BLUFF 19TH HOLE INC.',
  'WINE MERCHANTS LLC',
  'WLS BEVERAGE COMPANY',
  'YOUNT RIDGE CELLARS LLC',
  'ZAGHLOUL, ANTON NICOLA',
  'ZEIF BUSINESS INC.'
) ORDER BY owner_name, trade_name, license_rank, license_number;