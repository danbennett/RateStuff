#import <Kiwi/Kiwi.h>
#import "OCMockito/OCMockito.h"
#import "OCHamcrest/OCHamcrest.h"
#import "DBGroupService.h"
#import "DBGroupRepository.h"
#import "DBAreaRepository.h"
#import "DBItemRepository.h"

SPEC_BEGIN(DBGroupServiceSpec)

describe(@"DBGroupService", ^{
	
	__block DBGroupService *subject = nil;
	__block id<DBGroupRepository> groupRepo = nil;
	__block id<DBAreaRepository> areaRepo = nil;
	__block id<DBItemRepository> itemRepo = nil;
	
	beforeAll(^{
		groupRepo = MKTMockProtocol(@protocol(DBGroupRepository));
		areaRepo = MKTMockProtocol(@protocol(DBAreaRepository));
		itemRepo = MKTMockProtocol(@protocol(DBItemRepository));
		
		subject = [[DBGroupService alloc] initWithGroupRepository: groupRepo
												   areaRepository: areaRepo
												   itemRepository: itemRepo];
	});
	
	context(@"When calling createBlankGroup", ^{
		it(@"it should createEntity on the group repo", ^{
			
			[subject createBlankGroup];
			[MKTVerify(groupRepo) createEntity];
			
		});
	});
	
});

SPEC_END