
pragma solidity ^0.4.24;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address private _owner;

  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() internal {
    _owner = msg.sender;
    emit OwnershipTransferred(address(0), _owner);
  }

  /**
   * @return the address of the owner.
   */
  function owner() public view returns(address) {
    return _owner;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(isOwner());
    _;
  }

  /**
   * @return true if `msg.sender` is the owner of the contract.
   */
  function isOwner() public view returns(bool) {
    return msg.sender == _owner;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   * @notice Renouncing to ownership will leave the contract without an owner.
   * It will not be possible to call the functions with the `onlyOwner`
   * modifier anymore.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  /**
   * @dev Transfers control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0));
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}

contract AmisStorage is Ownable {

  struct TellerPosition {
    int256 lat;
    int256 lng;
    uint zoneId;
  }

  struct TellerProfile {
    int8 avatarId;
    int8 currencyId;
    bytes32 messagingAddr;
    bytes32 name;
    uint nbTrade;
    int16 rate;
    uint volumeTrade;
  }

  struct Teller {
    TellerPosition tellerPosition;
    TellerProfile tellerProfile;
    uint balance;
    uint index;         // the corresponding row number in the index
  }

  mapping(address => Teller) tellers;
  mapping (uint => address[]) public tellerPerZone;
  address[] public tellerIndex; // unordered list of keys that actually exist

  event LogDeleteTeller(address tellerAddress, uint rowToDelete);
  event LogUpdateTeller(address keyToMove, uint rowToDelete);


  // Teller Position
  function setTellerPosition(address _address, int256 lat, int256 lng, uint zoneId) onlyOwner {
    tellers[_address].tellerPosition = TellerPosition(lat, lng, zoneId);
  }

  function getTellerPosition(address _teller) view returns (
    int256 lat,
    int256 lng,
    uint zoneId) {
    return (
      tellers[_teller].tellerPosition.lat,
      tellers[_teller].tellerPosition.lng,
      tellers[_teller].tellerPosition.zoneId
    );
  }


  // Teller Profile
  function setTellerProfile(
    address _address,
    int8 _avatarId,
    int8 _currencyId,
    bytes32 _messagingAddr,
    bytes32 _name,
    int16 _rate) onlyOwner {
      tellers[_address].tellerProfile.avatarId = _avatarId;
      tellers[_address].tellerProfile.currencyId = _currencyId;
      tellers[_address].tellerProfile.messagingAddr = _messagingAddr;
      tellers[_address].tellerProfile.name = _name;
      tellers[_address].tellerProfile.rate = _rate;
  }

  function getTellerProfile(address _teller) view returns (
    int16 rate,
    uint volumeTrade,
    uint nbTrade,
    bytes32 name,
    int8 currencyId,
    int8 avatarId,
    bytes32 messagingAddr) {
      return (
        tellers[_teller].tellerProfile.rate,
        tellers[_teller].tellerProfile.volumeTrade,
        tellers[_teller].tellerProfile.nbTrade,
        tellers[_teller].tellerProfile.name,
        tellers[_teller].tellerProfile.currencyId,
        tellers[_teller].tellerProfile.avatarId,
        tellers[_teller].tellerProfile.messagingAddr
      );
  }


  // Teller Zone
  function setTellerZone(address _address, uint _zoneId) onlyOwner {
    if (tellers[_address].tellerPosition.zoneId != _zoneId) {
      tellerPerZone[_zoneId].push(_address);
    }
  }

  function getZone(uint _zone) view returns (address[]) {
    return tellerPerZone[_zone];
  }


  // Teller Reputation
  function setTellerReputation(address _address, uint _nbTrade, uint _volumeTrade) onlyOwner {
    tellers[_address].tellerProfile.nbTrade = _nbTrade;
    tellers[_address].tellerProfile.volumeTrade = _volumeTrade;
  }

  function getTellerReputation(address _address) view returns (uint nbTrade, uint volumeTrade) {
      return (tellers[_address].tellerProfile.nbTrade, tellers[_address].tellerProfile.volumeTrade);
  }


  // Teller Balance
  function setTellerBalance(address _address, uint _balance) onlyOwner payable {
    tellers[_address].balance = _balance;
  }

  function getTellerBalance(address _address) view returns (uint) {
    return tellers[_address].balance;
  }


  // Misc
  function clearMessagingAddress(address _address) onlyOwner returns (bool){
    tellers[_address].tellerProfile.messagingAddr = "";
    return true;
  }

  function isTeller(address _address) view returns (bool isIndeed) {
    if(tellerIndex.length == 0) return false;
    return (tellerIndex[tellers[_address].index] == _address);
  }

  function setTellerIndex(address _address) onlyOwner {
    if (!isTeller(_address)) {
      tellers[_address].index = tellerIndex.push(_address) - 1;
    }
  }

  function getTellerCount() view returns (uint count) {
    return tellerIndex.length;
  }

  function getTellerAtIndex(uint _index) view returns (address teller) {
    return tellerIndex[_index];
  }

  function getAllTellers() view returns (address[]) {
    return tellerIndex;
  }

  function releaseEth(address _receiver, uint _amount) onlyOwner returns (bool) {
    _receiver.transfer(_amount);
  }

  // Delete teller
  function deleteTeller(address _address) onlyOwner {
    // Conditions
    require(isTeller(_address));
    //
    uint rowToDelete = tellers[_address].index;
    address keyToMove = tellerIndex[tellerIndex.length - 1];
    tellerIndex[rowToDelete] = keyToMove;
    tellers[keyToMove].index = rowToDelete;
    tellerIndex.length--;
    emit LogDeleteTeller(_address, rowToDelete);
    emit LogUpdateTeller(keyToMove, rowToDelete);
  }
}