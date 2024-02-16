BeginPackage["WolframExternalFunctions`NetworkCollection`"];

IPAddressVersion::usage = "IPAddressVersion[address] returns the IP version of the given address.";
CompressIPAddress::usage = "CompressIPAddress[address] returns the compressed form of the given address.";
UncompressIPAddress::usage = "UncompressIPAddress[address] returns the uncompressed form of the given address.";
IPAddressToByteArray::usage = "IPAddressToByteArray[address] returns the byte array of the given address.";
(*
ByteArrayToIPAddress::usage = "ByteArrayToIPAddress[address] returns the IP address of the given byte array.";
*)
ReverseIPAddress::usage = "ReverseIPAddress[address] returns the reverse pointer of the given address.";
IPAddressMulticastQ::usage = "IPAddressMulticastQ[address] returns True if the given address is a multicast address.";
IPAddressPrivateQ::usage = "IPAddressPrivateQ[address] returns True if the given address is a private address.";
IPAddressGlobalQ::usage = "IPAddressGlobalQ[address] returns True if the given address is a global address.";
IPAddressLoopbackQ::usage = "IPAddressLoopbackQ[address] returns True if the given address is a loopback address.";
ConvertToIPV4Address::usage = "ConvertToIPV4Address[address] returns the IPv4 address of the given IPv6 address.";

Begin["`Private`"]

getSession[id_String, dependencies_List] := Module[{env},
  env = {"Python", "ID" -> id, "Evaluator" -> <|"Dependencies" -> dependencies, "EnvironmentName" -> id|>};
  SelectFirst[ExternalSessions[], #["ID"] == id &, StartExternalSession[env]]
  ]

session = getSession["ipaddress", {}];
ExternalEvaluate[session, "import ipaddress"];

IPAddressVersion[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).version"][address];
IPAddressVersion[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).version"][First@address];

CompressIPAddress[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).compressed"][address];
CompressIPAddress[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).compressed"][First@address];

UncompressIPAddress[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).exploded"][address];
UncompressIPAddress[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).exploded"][First@address];

IPAddressToByteArray[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).packed"][address];
IPAddressToByteArray[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).packed"][First@address];

ReverseIPAddress[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).reverse_pointer"][address];
ReverseIPAddress[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).reverse_pointer"][First@address];

IPAddressMulticastQ[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).is_multicast"][address];
IPAddressMulticastQ[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).is_multicast"][First@address];

IPAddressPrivateQ[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).is_private"][address];
IPAddressPrivateQ[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).is_private"][First@address];

IPAddressGlobalQ[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).is_global"][address];
IPAddressGlobalQ[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).is_global"][First@address];

IPAddressLoopbackQ[address_String] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).is_loopback"][address];
IPAddressLoopbackQ[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).is_loopback"][First@address];

ConvertToIPV4Address[address_String] := ExternalFunction[session, "lambda address: str(ipaddress.ip_address(address).sixtofour)"][address];
ConvertToIPV4Address[address_IPAddress] := ExternalFunction[session, "lambda address: ipaddress.ip_address(address).sixtofour"][First@address];

End[]
EndPackage[]