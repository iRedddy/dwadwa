


#import "vm_writeData.h"

#import "Esp/ImGuiDrawView.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
#include "KittyMemory/imgui.h"
#include "KittyMemory/imgui_impl_metal.h"
#import <Foundation/Foundation.h>
#import "Esp/CaptainHook.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define kTest   0 
#define g 0.86602540378444 

@interface ImGuiDrawView () <MTKViewDelegate>
//@property (nonatomic, strong) IBOutlet MTKView *mtkView;
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;






@property (nonatomic,  strong) UILabel *numberLabel;


@property (nonatomic,  strong) CAShapeLayer *Line_Red;
@property (nonatomic,  strong) CAShapeLayer *Line_Green;

@property (nonatomic, strong) NSArray *numberData;
@property (nonatomic,  strong) CAShapeLayer *renji;
@property (nonatomic,  strong) NSArray *rects;
@property (nonatomic,  strong) NSArray *aiData;
@property (nonatomic,  strong) NSArray *hpData;
@property (nonatomic,  strong) NSArray *disData;
@property (nonatomic,  strong) NSArray *nameData;
@property (nonatomic,  strong) NSArray *data1;
@property (nonatomic,  strong) NSArray *data2;
@property (nonatomic,  strong) NSArray *data3;
@property (nonatomic,  strong) NSArray *data4;
@property (nonatomic,  strong) NSArray *data5;
@property (nonatomic,  strong) NSArray *data6;
@property (nonatomic,  strong) NSArray *data7;
@property (nonatomic,  strong) NSArray *data8;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *juli;
@property (nonatomic,  weak) NSTimer *timer;
@property  char renshu;

@property (nonatomic, copy) NSString *zhutitle;
@property (nonatomic, copy) NSString *fubiaoti;
@property (nonatomic, copy) NSString *kaiguan;
@property (nonatomic, copy) NSString *shexian;
@property (nonatomic, copy) NSString *guge;
@property (nonatomic, copy) NSString *xuetiao;
@property (nonatomic, copy) NSString *xinxi;
@property (nonatomic, copy) NSString *fujin;
@property (nonatomic, copy) NSString *quan;




@end


float headx;
float heady;
#define Red 0x990000ff
#define Green 0x9900FF00
#define Yellow 0x9900ffff
#define Blue 0x99ff0000
#define Pink 0x99eb8cfe
#define White 0xffffffff

@implementation ImGuiDrawView


static bool MenDeal = true;


- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

     ImGui::StyleColorsClassic();

    
NSString *FontPath = @"/System/Library/Fonts/AppFonts/AppleGothic.otf";
    io.Fonts->AddFontFromFileTTF(FontPath.UTF8String, 40.f,NULL,io.Fonts->GetGlyphRangesChineseSimplifiedCommon());



    
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

- (void)loadView
{
    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
}

- (void)conData:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData nameData:(NSArray *)nameData aiData:(NSArray *)aiData numberData:(NSArray *)numberData data1:(NSArray *)data1  data2:(NSArray *)data2 data3:(NSArray *)data3 data4:(NSArray *)data4 data5:(NSArray *)data5 data6:(NSArray *)data6 data7:(NSArray *)data7 data8:(NSArray *)data8
{

    _rects = rects;
    _hpData = hpData;
    _disData = disData;
    _nameData = nameData;
    _aiData = aiData;
    _numberData = numberData;
    _data1 =  data1;
    _data2 =  data2;
    _data3 =  data3;
    _data4 =  data4;
    _data5 =  data5;
    _data6 =  data6;
    _data7 =  data7;
    _data8 =  data8;
     _numberLabel.text = @(_rects.count).stringValue;
//



}







#pragma mark - Interaction


- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

#pragma mark - MTKViewDelegate

- (void)drawInMTKView:(MTKView*)view
{
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];


    bool active_tab = 0;
    
    static bool show_lien = false;
    static bool show_guge = false;
    static bool show_name = false;
    static bool show_number = false;
    static bool show_xuetiao = false;
    static bool show_xinxi = false;
    static bool show_wuhou = false;
    static bool show_fanwei = false;
    static bool show_neifang = false;


    static bool show_ban = true;
    static bool show_names = false;
    static bool show_esp = true;
    static bool show_aim = true;
    static bool show_recoil = false;
    static bool show_spread = false;
    static bool show_speed = false;
    static bool show_slide = false;
    static bool show_scope = true;
    static bool show_reload = true;
    static bool show_L1 = false;
    static bool show_L2 = false;
    static bool show_L3 = false;
    static bool show_L4 = false;
    static bool show_L5 = true;
	static bool show_round = true;
	static int circle_size = 40;
    static int e = -1;
    static int z = -1;
    static int ban = -1;


 
        
        //
        if (MenDeal == true) {
            [self.view setUserInteractionEnabled:YES];
        } else if (MenDeal == false) {
            [self.view setUserInteractionEnabled:NO];
        }

        MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            ImFont* font = ImGui::GetFont();
            font->Scale = 16.f / font->FontSize;
            
            CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 380) / 2;
            CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 260) / 2;
            
            ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowSize(ImVec2(480, 180), ImGuiCond_FirstUseEver);
            
                if (MenDeal == true)
            {
                
                ImGui::Begin("t.me/shrinoware ~ Call of Duty© Mobile 1.0.31", &MenDeal);
{
if (ImGui::BeginTabBar("##tabbarmain")) {
if (ImGui::BeginTabItem("Main"))
{
        ImGui::Spacing();
        ImGui::Checkbox("Aim Assist++", &show_aim); ImGui::SameLine(120);
        ImGui::Checkbox("ESP - Map & Body", &show_esp); ImGui::SameLine(260);
        ImGui::Checkbox("No Reload", &show_reload);
        ImGui::Spacing();
        ImGui::Checkbox("Fast Scope", &show_scope); ImGui::SameLine(100);
        ImGui::Checkbox("Movement", &show_spread);
        ImGui::Spacing();


      ImGui::EndTabItem();
}

if (ImGui::BeginTabItem("Settings"))
{
   ImGui::Spacing();
   ImGui::Checkbox("ANTIBAN", &show_ban); ImGui::SameLine();
   ImGui::Spacing();
   ImGui::Separator();
   ImGui::Checkbox("FOV", &show_round);
	ImGui::SliderInt("Slider FOV", &circle_size, 0, 100, %.3f "Circle size");
	ImGui::Separator();
	ImGui::Spacing();
		}
	}	
ImGui::EndTabBar();

ImGui::Text("Telegram: t.me/shrinoware ©2022\n@shrino is the only seller. Anybody else claiming is a scammer!\n %.3f ms/frame (%.1f FPS)", 60.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
                }ImGui::End();
                
            }

         if (show_ban) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{

vm_writeData(0x106B3D79C, 0xC0035FD6);
vm_writeData(0x106B3E00C, 0xC0035FD6);
vm_writeData(0x106B3E0B8, 0xC0035FD6);
vm_writeData(0x106AE3D2C, 0xC0035FD6);
vm_writeData(0x106AF6448, 0xC0035FD6);
vm_writeData(0x106AF6A3C, 0xC0035FD6);
vm_writeData(0x106AF6664, 0xC0035FD6);
vm_writeData(0x10663E6C4, 0xC0035FD6);
vm_writeData(0x10663E320, 0xC0035FD6);
vm_writeData(0x10663EA6C, 0xC0035FD6);
vm_writeData(0x1036185AC, 0xC0035FD6);
vm_writeData(0x1069DA138, 0xC0035FD6);
vm_writeData(0x1069DEC54, 0xC0035FD6);
vm_writeData(0x106A7A060, 0xC0035FD6);
vm_writeData(0x106A484C4, 0xC0035FD6);
vm_writeData(0x1069900D4, 0xC0035FD6);
vm_writeData(0x106A08DAC, 0xC0035FD6);
vm_writeData(0x1069A7A80, 0xC0035FD6);


vm_writeData(0x105490F84, 0xC0035FD6);
vm_writeData(0x1069D9E7C, 0xC0035FD6);
vm_writeData(0x106A01324, 0xC0035FD6);
vm_writeData(0x106A26088, 0xC0035FD6);

});
                      
}

if (show_esp) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{

vm_writeData(0x1029FF69C, 0x00F0271E);   
vm_writeData(0x1029FF6A0, 0xC0035FD6);

vm_writeData(0x103352610, 0x200080D2);   
vm_writeData(0x103352614, 0xC0035FD6);

                                                 });
                      
}

if (show_aim) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{

vm_writeData(0x1035540A8, 0x00F0271E);   
vm_writeData(0x1035540AC, 0x0008201E);
vm_writeData(0x1035540B0, 0xC0035FD6);

vm_writeData(0x1036A02DC, 0xC0035FD6);

vm_writeData(0x10369D8B4, 0x9F2003D5);
                                                 });

}

if (show_scope) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{

vm_writeData(0x10306B604, 0x200080D2);
vm_writeData(0x10306B608, 0xC0035FD6);

                                                 });
                      
}

if (show_speed) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{

vm_writeData(0x10357E49C, 0x0010201E);
vm_writeData(0x10357E4A0, 0xC0035FD6);

                                                 });
                      
}

if (show_reload) {
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{

vm_writeData(0x1036773AC, 0x00102C1E);
                                                 });
                      
}

if (show_round) Draw->AddCircle(ImVec2(kWidth/2, kHeight/2), circle_size, Im_U32(255, 0, 0, 255), 100, 1.0f);

            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);

            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}


- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
    
}
- (void)fuyanqaq:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData nameData:(NSArray *)nameData aiData:(NSArray *)aiData data1:(NSArray *)data1  data2:(NSArray *)data2 data3:(NSArray *)data3 data4:(NSArray *)data4 data5:(NSArray *)data5 data6:(NSArray *)data6 data7:(NSArray *)data7 data8:(NSArray *)data8
{
    self->_rects = rects;
    self->_hpData = hpData;
    self->_disData = disData;
    self->_nameData = nameData;
    self->_aiData = aiData;
    self->_data1 =  data1;
    self->_data2 =  data2;
    self->_data3 =  data3;
    self->_data4 =  data4;
    self->_data5 =  data5;
    self->_data6 =  data6;
    self->_data7 =  data7;
    self->_data8 =  data8;
    
}



@end