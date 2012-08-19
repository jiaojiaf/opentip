
$ = ender

describe "Opentip - Appearing", ->
  adapter = Opentip.adapters.native
  beforeEach ->
    Opentip.adapter = adapter

  describe "prepareToShow()", ->
    opentip = null
    beforeEach ->
      opentip = new Opentip adapter.create("<div></div>"), "Test"
    afterEach ->
      opentip[prop].restore?() for prop of opentip

    it "should always abort a hiding process", ->
      sinon.stub opentip, "_abortHiding"
      opentip.prepareToShow()
      expect(opentip._abortHiding.callCount).to.be 1
    it "even when aborting because it's already visible", ->
      sinon.stub opentip, "_abortHiding"
      opentip.visible = yes
      opentip.prepareToShow()
      expect(opentip._abortHiding.callCount).to.be 1

    it "should abort when already visible", ->
      expect(opentip.preparingToShow).to.not.be.ok()
      opentip.visible = yes
      opentip.prepareToShow()
      expect(opentip.preparingToShow).to.not.be.ok()
      opentip.visible = no
      opentip.prepareToShow()
      expect(opentip.preparingToShow).to.be.ok()

    it "should setup observers for 'showing'", ->
      sinon.stub opentip, "_setupObservers"
      opentip.prepareToShow()
      expect(opentip._setupObservers.callCount).to.be 1
      expect(opentip._setupObservers.getCall(0).args[0]).to.be "showing"